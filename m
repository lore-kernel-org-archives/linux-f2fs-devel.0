From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: turn quota off when error occurs
Date: Sun, 22 Oct 2017 09:01:38 -0700
Message-ID: <20171022160138.GA33480@jaegeuk-macbookpro.roam.corp.google.com>
References: <20171020155337.5354-1-jaegeuk@kernel.org>
 <d150c646-64fd-84a0-4fc7-837b9efcb85e@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <jaegeuk@kernel.org>) id 1e6IhC-00009D-FI
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 22 Oct 2017 16:01:50 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1e6IhB-0005uN-N9
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 22 Oct 2017 16:01:50 +0000
Content-Disposition: inline
In-Reply-To: <d150c646-64fd-84a0-4fc7-837b9efcb85e@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 10/22, Chao Yu wrote:
> On 2017/10/20 23:53, Jaegeuk Kim wrote:
> > Before changing readonly, it needs to turn quota off.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/checkpoint.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> > index 201608281681..ff74665d7f2d 100644
> > --- a/fs/f2fs/checkpoint.c
> > +++ b/fs/f2fs/checkpoint.c
> > @@ -29,6 +29,7 @@ struct kmem_cache *inode_entry_slab;
> >  void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi, bool end_io)
> >  {
> >  	set_ckpt_flags(sbi, CP_ERROR_FLAG);
> > +	f2fs_quota_off_umount(sb);
> >  	sbi->sb->s_flags |= MS_RDONLY;
> >  	if (!end_io)
> 
> Oh, f2fs_stop_checkpoint can be called from end_io, how about adding
> f2fs_quota_off_umount here?

Agreed.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 201608281681..b38b1ae59124 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -29,9 +29,13 @@ struct kmem_cache *inode_entry_slab;
 void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi, bool end_io)
 {
 	set_ckpt_flags(sbi, CP_ERROR_FLAG);
-	sbi->sb->s_flags |= MS_RDONLY;
-	if (!end_io)
+	if (!end_io) {
+		f2fs_quota_off_umount(sbi->sb);
+		sbi->sb->s_flags |= MS_RDONLY;
 		f2fs_flush_merged_writes(sbi);
+	} else {
+		sbi->sb->s_flags |= MS_RDONLY;
+	}
 }
 
 /*
-- 
2.14.0.rc1.383.gd1ce394fe2-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
