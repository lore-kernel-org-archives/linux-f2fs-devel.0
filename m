From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 5/6] sload.f2fs: update build for android
Date: Thu, 30 Nov 2017 21:51:56 -0800
Message-ID: <20171201055157.72846-5-jaegeuk@kernel.org>
References: <20171201055157.72846-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <jaegeuk@kernel.org>) id 1eKeFJ-0003lz-If
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Dec 2017 05:52:21 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eKeFH-0006KK-PX
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Dec 2017 05:52:21 +0000
In-Reply-To: <20171201055157.72846-1-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch updates sload.f2fs for android build.

- do fsck() after sload() to update quota information.
- return success, if there's no source directory

  -C fs_config

  -f source directory [path of the source directory]

  -p product out directory
    : path on fs_config file for uid/gid/mode

  -s file_contexts
    : selabel file

  -t mount point [prefix of target fs path, default:/]
     : path stored in selabel/fs_config files

  -T timestamp

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/dir.c               |   9 +-
 fsck/fsck.h              |   3 +-
 fsck/main.c              |  79 ++++++++++++--
 fsck/mount.c             |   3 +
 fsck/segment.c           |   7 +-
 fsck/sload.c             | 276 ++++++++++++++++++++++++++++-------------------
 fsck/xattr.c             |   1 -
 include/android_config.h |   8 ++
 include/f2fs_fs.h        |  12 +++
 lib/libf2fs.c            |   1 +
 10 files changed, 273 insertions(+), 126 deletions(-)

diff --git a/fsck/dir.c b/fsck/dir.c
index 273e762..b2ea18f 100644
--- a/fsck/dir.c
+++ b/fsck/dir.c
@@ -620,9 +620,12 @@ int f2fs_create(struct f2fs_sb_info *sbi, struct dentry *de)
 	ASSERT(ret >= 0);
 
 	update_free_segments(sbi);
-	MSG(1, "Info: Create \"%s\" type=%x, ino=%x / %x into \"%s\"\n",
-			de->full_path, de->file_type,
-			de->ino, de->pino, de->path);
+	MSG(1, "Info: Create %s -> %s\n"
+		"  -- ino=%x, type=%x, mode=%x, uid=%x, "
+		"gid=%x, cap=%"PRIx64", size=%lu, pino=%x\n",
+		de->full_path, de->path,
+		de->ino, de->file_type, de->mode,
+		de->uid, de->gid, de->capabilities, de->size, de->pino);
 free_child_dir:
 	free(child);
 free_parent_dir:
diff --git a/fsck/fsck.h b/fsck/fsck.h
index 15ac848..0343fbd 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -216,8 +216,7 @@ int f2fs_defragment(struct f2fs_sb_info *, u64, u64, u64, int);
 int f2fs_resize(struct f2fs_sb_info *);
 
 /* sload.c */
-int f2fs_sload(struct f2fs_sb_info *, const char *, const char *,
-		const char *, struct selabel_handle *);
+int f2fs_sload(struct f2fs_sb_info *);
 
 /* segment.c */
 void reserve_new_block(struct f2fs_sb_info *, block_t *,
diff --git a/fsck/main.c b/fsck/main.c
index ba247d4..a09ca76 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -23,6 +23,24 @@
 
 struct f2fs_fsck gfsck;
 
+static char *absolute_path(const char *file)
+{
+	char *ret;
+	char cwd[PATH_MAX];
+
+	if (file[0] != '/') {
+		if (getcwd(cwd, PATH_MAX) == NULL) {
+			fprintf(stderr, "Failed to getcwd\n");
+			exit(EXIT_FAILURE);
+		}
+		ret = malloc(strlen(cwd) + 1 + strlen(file) + 1);
+		if (ret)
+			sprintf(ret, "%s/%s", cwd, file);
+	} else
+		ret = strdup(file);
+	return ret;
+}
+
 void fsck_usage()
 {
 	MSG(0, "\nUsage: fsck.f2fs [options] device\n");
@@ -76,8 +94,12 @@ void sload_usage()
 {
 	MSG(0, "\nUsage: sload.f2fs [options] device\n");
 	MSG(0, "[options]:\n");
+	MSG(0, "  -C fs_config\n");
 	MSG(0, "  -f source directory [path of the source directory]\n");
+	MSG(0, "  -p product out directory\n");
+	MSG(0, "  -s file_contexts\n");
 	MSG(0, "  -t mount point [prefix of target fs path, default:/]\n");
+	MSG(0, "  -T timestamp\n");
 	MSG(0, "  -d debug level [default:0]\n");
 	exit(1);
 }
@@ -367,11 +389,20 @@ void f2fs_parse_options(int argc, char *argv[])
 				break;
 		}
 	} else if (!strcmp("sload.f2fs", prog)) {
-		const char *option_string = "d:f:t:";
+		const char *option_string = "C:d:f:p:s:t:T:";
+#ifdef HAVE_LIBSELINUX
+		int max_nr_opt = (int)sizeof(c.seopt_file) /
+			sizeof(c.seopt_file[0]);
+		char *token;
+#endif
+		char *p;
 
 		c.func = SLOAD;
 		while ((option = getopt(argc, argv, option_string)) != EOF) {
 			switch (option) {
+			case 'C':
+				c.fs_config_file = absolute_path(optarg);
+				break;
 			case 'd':
 				if (!is_digits(optarg)) {
 					err = EWRONG_OPT;
@@ -382,11 +413,37 @@ void f2fs_parse_options(int argc, char *argv[])
 						c.dbg_lv);
 				break;
 			case 'f':
-				c.from_dir = (char *)optarg;
+				c.from_dir = absolute_path(optarg);
+				break;
+			case 'p':
+				c.target_out_dir = absolute_path(optarg);
+				break;
+			case 's':
+#ifdef HAVE_LIBSELINUX
+				token = strtok(optarg, ",");
+				while (token) {
+					if (c.nr_opt == max_nr_opt) {
+						MSG(0, "\tError: Expected at most %d selinux opts\n",
+										max_nr_opt);
+						error_out(prog);
+					}
+					c.seopt_file[c.nr_opt].type =
+								SELABEL_OPT_PATH;
+					c.seopt_file[c.nr_opt].value =
+								absolute_path(token);
+					c.nr_opt++;
+					token = strtok(NULL, ",");
+				}
+#else
+				MSG(0, "Info: Not support selinux opts\n");
+#endif
 				break;
 			case 't':
 				c.mount_point = (char *)optarg;
 				break;
+			case 'T':
+				c.fixed_time = strtoul(optarg, &p, 0);
+				break;
 			default:
 				err = EUNKNOWN_OPT;
 				break;
@@ -591,14 +648,13 @@ static int do_resize(struct f2fs_sb_info *sbi)
 static int do_sload(struct f2fs_sb_info *sbi)
 {
 	if (!c.from_dir) {
-		MSG(0, "\tError: Need source directory\n");
-		sload_usage();
-		return -1;
+		MSG(0, "Info: No source directory, but it's okay.\n");
+		return 0;
 	}
 	if (!c.mount_point)
 		c.mount_point = "/";
 
-	return f2fs_sload(sbi, c.from_dir, c.mount_point, NULL, NULL);
+	return f2fs_sload(sbi);
 }
 
 int main(int argc, char **argv)
@@ -665,8 +721,15 @@ fsck_again:
 #endif
 #ifdef WITH_SLOAD
 	case SLOAD:
-		do_sload(sbi);
-		break;
+		if (do_sload(sbi))
+			goto out_err;
+
+		f2fs_do_umount(sbi);
+
+		/* fsck to fix missing quota */
+		c.func = FSCK;
+		c.fix_on = 1;
+		goto fsck_again;
 #endif
 	default:
 		ERR_MSG("Wrong program name\n");
diff --git a/fsck/mount.c b/fsck/mount.c
index 3efa298..f16f046 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -47,6 +47,9 @@ void update_free_segments(struct f2fs_sb_info *sbi)
 	char *progress = "-*|*-";
 	static int i = 0;
 
+	if (c.dbg_lv)
+		return;
+
 	MSG(0, "\r [ %c ] Free segments: 0x%x", progress[i % 5], get_free_segments(sbi));
 	fflush(stdout);
 	i++;
diff --git a/fsck/segment.c b/fsck/segment.c
index 695fc6a..4f8bdb4 100644
--- a/fsck/segment.c
+++ b/fsck/segment.c
@@ -328,6 +328,11 @@ int f2fs_build_file(struct f2fs_sb_info *sbi, struct dentry *de)
 
 	update_free_segments(sbi);
 
-	MSG(1, "Info: built a file %s, size=%lu\n", de->full_path, de->size);
+	MSG(1, "Info: Create %s -> %s\n"
+		"  -- ino=%x, type=%x, mode=%x, uid=%x, "
+		"gid=%x, cap=%"PRIx64", size=%lu, pino=%x\n",
+		de->full_path, de->path,
+		de->ino, de->file_type, de->mode,
+		de->uid, de->gid, de->capabilities, de->size, de->pino);
 	return 0;
 }
diff --git a/fsck/sload.c b/fsck/sload.c
index bfc79f2..27ce30f 100644
--- a/fsck/sload.c
+++ b/fsck/sload.c
@@ -20,30 +20,20 @@
 #endif
 
 #ifdef HAVE_LIBSELINUX
-#include <selinux/selinux.h>
-#include <selinux/label.h>
+static struct selabel_handle *sehnd = NULL;
 #endif
 
+typedef void (*fs_config_f)(const char *path, int dir,
+			    const char *target_out_path,
+			    unsigned *uid, unsigned *gid,
+			    unsigned *mode, uint64_t *capabilities);
+
+static fs_config_f fs_config_func = NULL;
+
 #ifdef WITH_ANDROID
-#include <selinux/label.h>
+#include <selinux/android.h>
 #include <private/android_filesystem_config.h>
-
-static void handle_selabel(struct dentry *de, int dir, char *target_out)
-{
-	uint64_t capabilities;
-	unsigned int mode = 0;
-	unsigned int uid = 0;
-	unsigned int gid = 0;
-
-	fs_config(de->path, dir, target_out, &uid,
-			&gid, &mode, &capabilities);
-	de->mode = mode;
-	de->uid = uid;
-	de->gid = gid;
-	de->capabilities = capabilities;
-}
-#else
-#define handle_selabel(...)
+#include <private/canned_fs_config.h>
 #endif
 
 static int filter_dot(const struct dirent *d)
@@ -66,14 +56,106 @@ static void f2fs_make_directory(struct f2fs_sb_info *sbi,
 	}
 }
 
+#ifdef HAVE_LIBSELINUX
+static int set_selinux_xattr(struct f2fs_sb_info *sbi, const char *path,
+							nid_t ino, int mode)
+{
+	char *secontext = NULL;
+
+	if (!sehnd)
+		return 0;
+
+	/* set root inode selinux context */
+	if (selabel_lookup(sehnd, &secontext, path, mode) < 0) {
+		ERR_MSG("cannot lookup security context for %s\n", path);
+		return -EINVAL;
+	}
+
+	if (secontext) {
+		MSG(2, "%s (%d) -> SELinux context = %s\n",
+						path, ino, secontext);
+		inode_set_selinux(sbi, ino, secontext);
+	}
+	freecon(secontext);
+	return 0;
+}
+#else
+#define set_selinux_xattr(...)	0
+#endif
+
+static int set_perms_and_caps(struct dentry *de)
+{
+	uint64_t capabilities = 0;
+	unsigned int uid = 0, gid = 0, imode = 0;
+
+	/* Permissions */
+	if (fs_config_func != NULL) {
+		fs_config_func(de->path, S_ISDIR(de->mode),
+				c.target_out_dir, &uid, &gid, &imode,
+				&capabilities);
+		de->uid = uid & 0xffff;
+		de->gid = gid & 0xffff;
+		de->mode = (de->mode & S_IFMT) | (imode & 0xffff);
+		de->capabilities = capabilities;
+	}
+	MSG(2, "%s -> mode = 0x%x, uid = 0x%x, gid = 0x%x, "
+			"capabilities = 0x%"PRIx64"\n",
+		de->path, de->mode, de->uid, de->gid, de->capabilities);
+	return 0;
+}
+
+static void set_inode_metadata(struct dentry *de)
+{
+	struct stat stat;
+	int ret;
+
+	ret = lstat(de->full_path, &stat);
+	if (ret < 0) {
+		ERR_MSG("lstat failure\n");
+		ASSERT(0);
+	}
+
+	if (S_ISREG(stat.st_mode)) {
+		de->file_type = F2FS_FT_REG_FILE;
+	} else if (S_ISDIR(stat.st_mode)) {
+		de->file_type = F2FS_FT_DIR;
+	} else if (S_ISCHR(stat.st_mode)) {
+		de->file_type = F2FS_FT_CHRDEV;
+	} else if (S_ISBLK(stat.st_mode)) {
+		de->file_type = F2FS_FT_BLKDEV;
+	} else if (S_ISFIFO(stat.st_mode)) {
+		de->file_type = F2FS_FT_FIFO;
+	} else if (S_ISSOCK(stat.st_mode)) {
+		de->file_type = F2FS_FT_SOCK;
+	} else if (S_ISLNK(stat.st_mode)) {
+		de->file_type = F2FS_FT_SYMLINK;
+		de->link = calloc(F2FS_BLKSIZE, 1);
+		ASSERT(de->link);
+		ret = readlink(de->full_path, de->link, F2FS_BLKSIZE - 1);
+		ASSERT(ret >= 0);
+	} else {
+		ERR_MSG("unknown file type on %s", de->path);
+		ASSERT(0);
+	}
+
+	de->size = stat.st_size;
+	de->mode = stat.st_mode &
+			(S_ISUID|S_ISGID|S_ISVTX|S_IRWXU|S_IRWXG|S_IRWXO);
+	if (c.fixed_time == -1 && c.from_dir)
+		de->mtime = stat.st_mtime;
+	else
+		de->mtime = c.fixed_time;
+
+	set_perms_and_caps(de);
+}
+
 static int build_directory(struct f2fs_sb_info *sbi, const char *full_path,
 			const char *dir_path, const char *target_out_dir,
-			nid_t dir_ino, struct selabel_handle *sehnd)
+			nid_t dir_ino)
 {
 	int entries = 0;
 	struct dentry *dentries;
 	struct dirent **namelist = NULL;
-	struct stat stat;
 	int i, ret = 0;
 
 	entries = scandir(full_path, &namelist, filter_dot, (void *)alphasort);
@@ -94,7 +176,7 @@ static int build_directory(struct f2fs_sb_info *sbi, const char *full_path,
 		}
 		dentries[i].len = strlen((char *)dentries[i].name);
 
-		ret = asprintf(&dentries[i].path, "%s/%s",
+		ret = asprintf(&dentries[i].path, "%s%s",
 					dir_path, namelist[i]->d_name);
 		ASSERT(ret > 0);
 		ret = asprintf(&dentries[i].full_path, "%s/%s",
@@ -102,52 +184,9 @@ static int build_directory(struct f2fs_sb_info *sbi, const char *full_path,
 		ASSERT(ret > 0);
 		free(namelist[i]);
 
-		ret = lstat(dentries[i].full_path, &stat);
-		if (ret < 0) {
-			ERR_MSG("Skip: lstat failure\n");
-			continue;
-		}
-		dentries[i].size = stat.st_size;
-		dentries[i].mode = stat.st_mode &
-			(S_ISUID|S_ISGID|S_ISVTX|S_IRWXU|S_IRWXG|S_IRWXO);
-		dentries[i].mtime = stat.st_mtime;
-
-		handle_selabel(dentries + i, S_ISDIR(stat.st_mode),
-							target_out_dir);
-
-#ifdef HAVE_LIBSELINUX
-		if (sehnd && selabel_lookup(sehnd, &dentries[i].secon,
-					dentries[i].path, stat.st_mode) < 0)
-			ERR_MSG("Cannot lookup security context for %s\n",
-						dentries[i].path);
-#endif
+		set_inode_metadata(dentries + i);
 
 		dentries[i].pino = dir_ino;
-
-		if (S_ISREG(stat.st_mode)) {
-			dentries[i].file_type = F2FS_FT_REG_FILE;
-		} else if (S_ISDIR(stat.st_mode)) {
-			dentries[i].file_type = F2FS_FT_DIR;
-		} else if (S_ISCHR(stat.st_mode)) {
-			dentries[i].file_type = F2FS_FT_CHRDEV;
-		} else if (S_ISBLK(stat.st_mode)) {
-			dentries[i].file_type = F2FS_FT_BLKDEV;
-		} else if (S_ISFIFO(stat.st_mode)) {
-			dentries[i].file_type = F2FS_FT_FIFO;
-		} else if (S_ISSOCK(stat.st_mode)) {
-			dentries[i].file_type = F2FS_FT_SOCK;
-		} else if (S_ISLNK(stat.st_mode)) {
-			dentries[i].file_type = F2FS_FT_SYMLINK;
-			dentries[i].link = calloc(F2FS_BLKSIZE, 1);
-			ASSERT(dentries[i].link);
-			ret = readlink(dentries[i].full_path,
-					dentries[i].link, F2FS_BLKSIZE - 1);
-			ASSERT(ret >= 0);
-		} else {
-			MSG(1, "unknown file type on %s", dentries[i].path);
-			i--;
-			entries--;
-		}
 	}
 
 	free(namelist);
@@ -159,9 +198,9 @@ static int build_directory(struct f2fs_sb_info *sbi, const char *full_path,
 			f2fs_build_file(sbi, dentries + i);
 		} else if (dentries[i].file_type == F2FS_FT_DIR) {
 			char *subdir_full_path = NULL;
-			char *subdir_dir_path;
+			char *subdir_dir_path = NULL;
 
-			ret = asprintf(&subdir_full_path, "%s/",
+			ret = asprintf(&subdir_full_path, "%s",
 							dentries[i].full_path);
 			ASSERT(ret > 0);
 			ret = asprintf(&subdir_dir_path, "%s/",
@@ -169,7 +208,7 @@ static int build_directory(struct f2fs_sb_info *sbi, const char *full_path,
 			ASSERT(ret > 0);
 
 			build_directory(sbi, subdir_full_path, subdir_dir_path,
-					target_out_dir, dentries[i].ino, sehnd);
+					target_out_dir, dentries[i].ino);
 			free(subdir_full_path);
 			free(subdir_dir_path);
 		} else if (dentries[i].file_type == F2FS_FT_SYMLINK) {
@@ -181,19 +220,10 @@ static int build_directory(struct f2fs_sb_info *sbi, const char *full_path,
 			MSG(1, "Error unknown file type\n");
 		}
 
-#ifdef HAVE_LIBSELINUX
-		if (dentries[i].secon) {
-			inode_set_selinux(sbi, dentries[i].ino, dentries[i].secon);
-			MSG(1, "File = %s \n----->SELinux context = %s\n",
-					dentries[i].path, dentries[i].secon);
-			MSG(1, "----->mode = 0x%x, uid = 0x%x, gid = 0x%x, "
-					"capabilities = 0x%lx \n",
-					dentries[i].mode, dentries[i].uid,
-					dentries[i].gid, dentries[i].capabilities);
-		}
-
-		free(dentries[i].secon);
-#endif
+		ret = set_selinux_xattr(sbi, dentries[i].path,
+					dentries[i].ino, dentries[i].mode);
+		if (ret)
+			return ret;
 
 		free(dentries[i].path);
 		free(dentries[i].full_path);
@@ -204,47 +234,71 @@ static int build_directory(struct f2fs_sb_info *sbi, const char *full_path,
 	return 0;
 }
 
-int f2fs_sload(struct f2fs_sb_info *sbi, const char *from_dir,
-				const char *mount_point,
-				const char *target_out_dir,
-				struct selabel_handle *sehnd)
+static int configure_files(void)
 {
-	int ret = 0;
-	nid_t mnt_ino = F2FS_ROOT_INO(sbi);
+#ifdef HAVE_LIBSELINUX
+	if (!c.nr_opt)
+		goto skip;
+#if !defined(__ANDROID__)
+	sehnd = selabel_open(SELABEL_CTX_FILE, c.seopt_file, c.nr_opt);
+	if (!sehnd) {
+		ERR_MSG("Failed to open file contexts \"%s\"",
+					c.seopt_file[0].value);
+			return -EINVAL;
+	}
+#else
+	sehnd = selinux_android_file_context_handle();
+	if (!sehnd) {
+		ERR_MSG("Failed to get android file_contexts\n", c.mount_point);
+		return -EINVAL;
+	}
+#endif
+skip:
+#endif
+#ifdef WITH_ANDROID
+	/* Load the FS config */
+	if (c.fs_config_file) {
+		int ret = load_canned_fs_config(c.fs_config_file);
 
-	/* flush NAT/SIT journal entries */
-	flush_journal_entries(sbi);
+		if (ret < 0) {
+			ERR_MSG("Failed to load fs_config \"%s\"",
+						c.fs_config_file);
+			return ret;
+		}
+		fs_config_func = canned_fs_config;
+	} else {
+		fs_config_func = fs_config;
+	}
+#endif
+	return 0;
+}
 
-	ret = f2fs_find_path(sbi, (char *)mount_point, &mnt_ino);
+int f2fs_sload(struct f2fs_sb_info *sbi)
+{
+	int ret = 0;
+
+	ret = configure_files();
 	if (ret) {
-		ERR_MSG("Failed to get mount point %s\n", mount_point);
+		ERR_MSG("Failed to configure files\n");
 		return ret;
 	}
 
-	ret = build_directory(sbi, from_dir, mount_point, target_out_dir,
-						mnt_ino, sehnd);
+	/* flush NAT/SIT journal entries */
+	flush_journal_entries(sbi);
+
+	ret = build_directory(sbi, c.from_dir, c.mount_point,
+					c.target_out_dir, F2FS_ROOT_INO(sbi));
 	if (ret) {
 		ERR_MSG("Failed to build due to %d\n", ret);
 		return ret;
 	}
 
-#ifdef HAVE_LIBSELINUX
-	if (sehnd) {
-		char *secontext = NULL;
-
-		/* set root inode selinux context */
-		if (selabel_lookup(sehnd, &secontext, mount_point, S_IFDIR) < 0)
-			ERR_MSG("cannot lookup security context for %s\n",
-								mount_point);
-		if (secontext) {
-			MSG(1, "Labeling %s as %s, root_ino = %d\n",
-					mount_point, secontext, F2FS_ROOT_INO(sbi));
-			/* xattr_add for root inode */
-			inode_set_selinux(sbi, F2FS_ROOT_INO(sbi), secontext);
-		}
-		free(secontext);
+	ret = set_selinux_xattr(sbi, c.mount_point,
+					F2FS_ROOT_INO(sbi), S_IFDIR);
+	if (ret) {
+		ERR_MSG("Failed to set selinux for root: %d\n", ret);
+		return ret;
 	}
-#endif
 
 	/* update curseg info; can update sit->types */
 	move_curseg_info(sbi, SM_I(sbi)->main_blkaddr);
diff --git a/fsck/xattr.c b/fsck/xattr.c
index f2576cd..1d15d1b 100644
--- a/fsck/xattr.c
+++ b/fsck/xattr.c
@@ -77,7 +77,6 @@ static void write_all_xattrs(struct f2fs_sb_info *sbi,
 	u64 inline_size = inline_xattr_size(&inode->i);
 	int ret;
 
-	ASSERT(inode->i.i_inline & F2FS_INLINE_XATTR);
 	memcpy(inline_xattr_addr(&inode->i), txattr_addr, inline_size);
 
 	if (hsize <= inline_size)
diff --git a/include/android_config.h b/include/android_config.h
index bfc4105..59ba1ee 100644
--- a/include/android_config.h
+++ b/include/android_config.h
@@ -28,6 +28,10 @@
 #define HAVE_LSEEK64 1
 #define HAVE_MEMSET 1
 #define HAVE_SETMNTENT 1
+
+#ifdef WITH_SLOAD
+#define HAVE_LIBSELINUX 1
+#endif
 #endif
 
 #if defined(__APPLE__)
@@ -51,4 +55,8 @@
 #define HAVE_KEYCTL 1
 #define HAVE_LLSEEK 1
 #define HAVE_MEMSET 1
+
+#ifdef WITH_SLOAD
+#define HAVE_LIBSELINUX 1
+#endif
 #endif
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 7e766a8..3084cce 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -39,6 +39,11 @@
 #include <linux/blkzoned.h>
 #endif
 
+#ifdef HAVE_LIBSELINUX
+#include <selinux/selinux.h>
+#include <selinux/label.h>
+#endif
+
 #ifdef UNUSED
 #elif defined(__GNUC__)
 # define UNUSED(x) UNUSED_ ## x __attribute__((unused))
@@ -359,6 +364,13 @@ struct f2fs_configuration {
 	/* sload parameters */
 	char *from_dir;
 	char *mount_point;
+	char *target_out_dir;
+	char *fs_config_file;
+	time_t fixed_time;
+#ifdef HAVE_LIBSELINUX
+	struct selinux_opt seopt_file[8];
+	int nr_opt;
+#endif
 
 	/* precomputed fs UUID checksum for seeding other checksums */
 	u_int32_t chksum_seed;
diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index 1e63843..bbe3a8b 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -614,6 +614,7 @@ void f2fs_init_configuration(void)
 	c.ro = 0;
 	c.kd = -1;
 	c.dry_run = 0;
+	c.fixed_time = -1;
 }
 
 #ifdef HAVE_SETMNTENT
-- 
2.15.0.403.gc27cc4dac6-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
