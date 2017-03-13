From: Kinglong Mee <kinglongmee@gmail.com>
Subject: Re: [PATCH v2] f2fs: restrict write IO alignment
	condition
Date: Mon, 13 Mar 2017 21:45:08 +0800
Message-ID: <e77a8fbc-47a3-1860-9168-0dc1516dcd1a@gmail.com>
References: <20170313130216.108395-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1cnQI4-0005zL-Eu
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 13 Mar 2017 13:45:36 +0000
Received: from mail-it0-f68.google.com ([209.85.214.68])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cnQI2-0006iZ-Eb
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 13 Mar 2017 13:45:36 +0000
Received: by mail-it0-f68.google.com with SMTP id w185so5972981ita.3
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 13 Mar 2017 06:45:34 -0700 (PDT)
In-Reply-To: <20170313130216.108395-1-yuchao0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>, jaegeuk@kernel.org
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 3/13/2017 21:02, Chao Yu wrote:
> We should only align start offset of bio with defined IO_SIZE for below
> conditions:
> a. mode=lfs mount option
> b. write IOs
> c. Out-place-update
> d. non-meta pages
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/data.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 1375fef11146..53fe79c70406 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -190,6 +190,9 @@ static inline void __submit_bio(struct f2fs_sb_info *sbi,
>  			current->plug && (type == DATA || type == NODE))
>  			blk_finish_plug(current->plug);
>  
> +		if (!test_opt(sbi, LFS))
> +			goto submit_io;
> +
>  		if (type != DATA && type != NODE)
>  			goto submit_io;

Is the position of checking LFS here right?

I have a plan of change the code order as, 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 2ab5ca0..698dbf3 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -186,13 +186,12 @@ static inline void __submit_bio(struct f2fs_sb_info *sbi,
        if (!is_read_io(bio_op(bio))) {
                unsigned int start;

-               if (f2fs_sb_mounted_blkzoned(sbi->sb) &&
-                       current->plug && (type == DATA || type == NODE))
-                       blk_finish_plug(current->plug);
-
                if (type != DATA && type != NODE)
                        goto submit_io;

+               if (f2fs_sb_mounted_blkzoned(sbi->sb) && current->plug)
+                       blk_finish_plug(current->plug);
+
                start = bio->bi_iter.bi_size >> F2FS_BLKSIZE_BITS;
                start %= F2FS_IO_SIZE(sbi);

thanks,
Kinglong Mee

>  
> @@ -395,11 +398,12 @@ int f2fs_submit_page_mbio(struct f2fs_io_info *fio)
>  		__submit_merged_bio(io);
>  alloc_new:
>  	if (io->bio == NULL) {
> -		if ((fio->type == DATA || fio->type == NODE) &&
> +		if (test_opt(sbi, LFS) &&
> +			!is_read && (fio->type == DATA || fio->type == NODE) &&
>  				fio->new_blkaddr & F2FS_IO_SIZE_MASK(sbi)) {
>  			err = -EAGAIN;
> -			if (!is_read)
> -				dec_page_count(sbi, WB_DATA_TYPE(bio_page));
> +			f2fs_bug_on(sbi, fio->new_blkaddr == fio->old_blkaddr);
> +			dec_page_count(sbi, WB_DATA_TYPE(bio_page));
>  			goto out_fail;
>  		}
>  		io->bio = __bio_alloc(sbi, fio->new_blkaddr,
> 

------------------------------------------------------------------------------
Announcing the Oxford Dictionaries API! The API offers world-renowned
dictionary content that is easy and intuitive to access. Sign up for an
account today to start using our lexical data to power your apps and
projects. Get started today and enter our developer competition.
http://sdm.link/oxford
