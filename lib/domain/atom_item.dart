import 'package:rss/domain/atom_category.dart';
import 'package:rss/domain/atom_link.dart';
import 'package:rss/domain/atom_person.dart';
import 'package:rss/domain/atom_source.dart';
import 'package:rss/domain/media/media.dart';
import 'package:rss/util/helpers.dart';
import 'package:xml/xml.dart';

class AtomItem {
  final String? id;
  final String? title;
  final String? updated;

  final List<AtomPerson> authors;
  final List<AtomLink> links;
  final List<AtomCategory> categories;
  final List<AtomPerson> contributors;
  final AtomSource? source;
  final String? published;
  final String? content;
  final String? summary;
  final String? rights;
  final Media? media;

  const AtomItem({
    this.id,
    this.title,
    this.updated,
    this.authors = const <AtomPerson>[],
    this.links = const <AtomLink>[],
    this.categories = const <AtomCategory>[],
    this.contributors = const <AtomPerson>[],
    this.source,
    this.published,
    this.content,
    this.summary,
    this.rights,
    this.media,
  });

  factory AtomItem.parse(XmlElement element) {
    return AtomItem(
      id: findElementOrNull(element, 'id')?.value,
      title: findElementOrNull(element, 'title')?.value,
      updated: findElementOrNull(element, 'updated')?.value,
      authors: element
          .findElements('author')
          .map((element) => AtomPerson.parse(element))
          .toList(),
      links: element
          .findElements('link')
          .map((element) => AtomLink.parse(element))
          .toList(),
      categories: element
          .findElements('category')
          .map((element) => AtomCategory.parse(element))
          .toList(),
      contributors: element
          .findElements('contributor')
          .map((element) => AtomPerson.parse(element))
          .toList(),
      source: AtomSource.parse(findElementOrNull(element, 'source')),
      published: findElementOrNull(element, 'published')?.value,
      content: findElementOrNull(element, 'content')?.value,
      summary: findElementOrNull(element, 'summary')?.value,
      rights: findElementOrNull(element, 'rights')?.value,
      media: Media.parse(element),
    );
  }
}
