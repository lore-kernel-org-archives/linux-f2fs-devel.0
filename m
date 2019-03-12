From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2] f2fs: fix to check inline_xattr_size boundary
 correctly
Date: Tue, 12 Mar 2019 11:50:57 -0700
Message-ID: <20190312185057.GB45421@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190214160825.4973-1-chao@kernel.org>
 <82ef0ff8-452c-1894-6776-41c70ad7654b@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <82ef0ff8-452c-1894-6776-41c70ad7654b@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 03/04, Chao Yu wrote:
> Hi Jaegeuk,
> 
> On 2019/2/15 0:08, Chao Yu wrote:
> > ---
> > v2:
> > - fix lower bound check, inline xattr size should be larger than
> > xattr_header's size at least.
> 
> ...
> 
> > +		if (F2FS_OPTION(sbi).inline_xattr_size <
> > +			sizeof(struct f2fs_xattr_header) / sizeof(__le32)
> 
> No sure we should set this low bound as above... now I guess original
> non-zero check is enough.
> 
> How do you think of setting inline_xattr_size range as
> (0, MAX_INLINE_XATTR_SIZE]?

How about this?

---
 fs/f2fs/super.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 42eb5c86330a..96302a428fdc 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -821,6 +821,8 @@ static int parse_options(struct super_block *sb, char *options)
 	}
 
 	if (test_opt(sbi, INLINE_XATTR_SIZE)) {
+		int min_size, max_size;
+
 		if (!f2fs_sb_has_extra_attr(sbi) ||
 			!f2fs_sb_has_flexible_inline_xattr(sbi)) {
 			f2fs_msg(sb, KERN_ERR,
@@ -834,15 +836,18 @@ static int parse_options(struct super_block *sb, char *options)
 					"set with inline_xattr option");
 			return -EINVAL;
 		}
-		if (F2FS_OPTION(sbi).inline_xattr_size <
-			sizeof(struct f2fs_xattr_header) / sizeof(__le32) ||
-			F2FS_OPTION(sbi).inline_xattr_size >
-			DEF_ADDRS_PER_INODE -
+
+		min_size = sizeof(struct f2fs_xattr_header) / sizeof(__le32);
+		max_size = DEF_ADDRS_PER_INODE -
 			F2FS_TOTAL_EXTRA_ATTR_SIZE / sizeof(__le32) -
 			DEF_INLINE_RESERVED_SIZE -
-			MIN_INLINE_DENTRY_SIZE / sizeof(__le32)) {
+			MIN_INLINE_DENTRY_SIZE / sizeof(__le32);
+
+		if (F2FS_OPTION(sbi).inline_xattr_size < min ||
+				F2FS_OPTION(sbi).inline_xattr_size > max) {
 			f2fs_msg(sb, KERN_ERR,
-					"inline xattr size is out of range");
+				"inline xattr size is out of range: %d ~ %d",
+				min, max);
 			return -EINVAL;
 		}
 	}
-- 
2.19.0.605.g01d371f741-goog
