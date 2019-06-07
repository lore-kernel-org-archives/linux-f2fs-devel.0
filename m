From: Kimberly Brown <kimbrownkd@gmail.com>
Subject: [PATCH] f2fs: replace ktype default_attrs with default_groups
Date: Fri,  7 Jun 2019 13:40:41 -0400
Message-ID: <20190607174041.11201-1-kimbrownkd@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, yuchao0@huawei.com, gregkh@linuxfoundation.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

The kobj_type default_attrs field is being replaced by the
default_groups field. Replace the default_attrs fields in f2fs_sb_ktype
and f2fs_feat_ktype with default_groups. Use the ATTRIBUTE_GROUPS macro
to create f2fs_groups and f2fs_feat_groups.

Signed-off-by: Kimberly Brown <kimbrownkd@gmail.com>
---
 fs/f2fs/sysfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 729f46a3c9ee..5c85166677d4 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -501,6 +501,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(current_reserved_blocks),
 	NULL,
 };
+ATTRIBUTE_GROUPS(f2fs);
 
 static struct attribute *f2fs_feat_attrs[] = {
 #ifdef CONFIG_FS_ENCRYPTION
@@ -520,6 +521,7 @@ static struct attribute *f2fs_feat_attrs[] = {
 	ATTR_LIST(sb_checksum),
 	NULL,
 };
+ATTRIBUTE_GROUPS(f2fs_feat);
 
 static const struct sysfs_ops f2fs_attr_ops = {
 	.show	= f2fs_attr_show,
@@ -527,7 +529,7 @@ static const struct sysfs_ops f2fs_attr_ops = {
 };
 
 static struct kobj_type f2fs_sb_ktype = {
-	.default_attrs	= f2fs_attrs,
+	.default_groups = f2fs_groups,
 	.sysfs_ops	= &f2fs_attr_ops,
 	.release	= f2fs_sb_release,
 };
@@ -541,7 +543,7 @@ static struct kset f2fs_kset = {
 };
 
 static struct kobj_type f2fs_feat_ktype = {
-	.default_attrs	= f2fs_feat_attrs,
+	.default_groups = f2fs_feat_groups,
 	.sysfs_ops	= &f2fs_attr_ops,
 };
 
-- 
2.17.1
