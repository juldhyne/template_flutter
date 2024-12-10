enum UploadFileType {
  profilePicture('profile-picture'),
  picture('picture'),
  document('document');

  const UploadFileType(this.value);
  final String value;
}
