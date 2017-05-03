From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 3/7] f2fs: Make flush bios explicitely sync
Date: Thu, 4 May 2017 00:20:49 +0800
Message-ID: <bbdb2c6a-142e-2cc8-d95e-f7124deac23b@kernel.org>
References: <20170502150351.29452-1-jack@suse.cz>
 <20170502150351.29452-4-jack@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20170502150351.29452-4-jack@suse.cz>
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/5/2 23:03, Jan Kara wrote:
> Commit b685d3d65ac7 "block: treat REQ_FUA and REQ_PREFLUSH as
> synchronous" removed REQ_SYNC flag from WRITE_{FUA|PREFLUSH|...}
> definitions.  generic_make_request_checks() however strips REQ_FUA and
> REQ_PREFLUSH flags from a bio when the storage doesn't report volatile
> write cache and thus write effectively becomes asynchronous which can
> lead to performance regressions.
> 
> Fix the problem by making sure all bios which are synchronous are
> properly marked with REQ_SYNC.
> 
> Fixes: b685d3d65ac791406e0dfd8779cc9b3707fea5a3
> CC: Jaegeuk Kim <jaegeuk@kernel.org>
> CC: linux-f2fs-devel@lists.sourceforge.net
> Signed-off-by: Jan Kara <jack@suse.cz>

Looks good to me. :)

Acked-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> ---
>  fs/f2fs/data.c    | 2 +-
>  fs/f2fs/segment.c | 2 +-
>  fs/f2fs/super.c   | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 1602b4bccae6..dd24476e8d2c 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -309,7 +309,7 @@ static void __f2fs_submit_merged_bio(struct f2fs_sb_info *sbi,
>  	if (type >= META_FLUSH) {
>  		io->fio.type = META_FLUSH;
>  		io->fio.op = REQ_OP_WRITE;
> -		io->fio.op_flags = REQ_META | REQ_PRIO;
> +		io->fio.op_flags = REQ_META | REQ_PRIO | REQ_SYNC;
>  		if (!test_opt(sbi, NOBARRIER))
>  			io->fio.op_flags |= REQ_PREFLUSH | REQ_FUA;
>  	}
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 29ef7088c558..0c24cec55dc9 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -416,7 +416,7 @@ static int __submit_flush_wait(struct block_device *bdev)
>  	struct bio *bio = f2fs_bio_alloc(0);
>  	int ret;
>  
> -	bio->bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
> +	bio->bi_opf = REQ_OP_WRITE | REQ_SYNC | REQ_PREFLUSH;
>  	bio->bi_bdev = bdev;
>  	ret = submit_bio_wait(bio);
>  	bio_put(bio);
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 96fe8ed73100..fa5af1f04798 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1307,7 +1307,7 @@ static int __f2fs_commit_super(struct buffer_head *bh,
>  	unlock_buffer(bh);
>  
>  	/* it's rare case, we can do fua all the time */
> -	return __sync_dirty_buffer(bh, REQ_PREFLUSH | REQ_FUA);
> +	return __sync_dirty_buffer(bh, REQ_SYNC | REQ_PREFLUSH | REQ_FUA);
>  }
>  
>  static inline bool sanity_check_area_boundary(struct f2fs_sb_info *sbi,
> 
