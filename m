From: He YunLei <heyunlei@huawei.com>
Subject: Re: [PATCH] back-up raw_super in sbi
Date: Mon, 14 Dec 2015 17:56:49 +0800
Message-ID: <566E9261.8040702@huawei.com>
References: <1449580633-17880-1-git-send-email-heyunlei@huawei.com>
	<20151208181902.GA10025@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1a8Psk-0001dT-Kq
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 14 Dec 2015 09:57:26 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1a8Psg-00034P-Aj
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 14 Dec 2015 09:57:26 +0000
In-Reply-To: <20151208181902.GA10025@jaegeuk.local>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: hebiao6@huawei.com, stuart.li@huawei.com, linux-f2fs-devel@lists.sourceforge.net

On 2015/12/9 2:19, Jaegeuk Kim wrote:
> Hi Yunlei,
>
> On Tue, Dec 08, 2015 at 09:17:13PM +0800, Yunlei He wrote:
>> write_checkpoint() tries to get cp_blkaddr from superblock buffer,
>> if the buffer happen to be destroied by something else, it may
>> bring in unpredictable effect on f2fs.
>>
>> this patch fix it by back-up a raw_super copy.
>>
>> Signed-off-by: Yunlei He <heyunlei@huawei.com>
>> ---
>>   fs/f2fs/checkpoint.c |  3 ++-
>>   fs/f2fs/f2fs.h       | 10 ++++++++++
>>   fs/f2fs/node.c       |  2 +-
>>   fs/f2fs/super.c      | 12 ++++++++----
>>   4 files changed, 21 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>> index f661d80..1e342fd 100644
>> --- a/fs/f2fs/checkpoint.c
>> +++ b/fs/f2fs/checkpoint.c
>> @@ -276,13 +276,14 @@ long sync_meta_pages(struct f2fs_sb_info *sbi, enum page_type type,
>>   						long nr_to_write)
>>   {
>>   	struct address_space *mapping = META_MAPPING(sbi);
>> -	pgoff_t index = 0, end = LONG_MAX, prev = LONG_MAX;
>> +	pgoff_t index, end = LONG_MAX, prev = LONG_MAX;
>>   	struct pagevec pvec;
>>   	long nwritten = 0;
>>   	struct writeback_control wbc = {
>>   		.for_reclaim = 0,
>>   	};
>>
>> +	index = __start_cp_addr(sbi);
>
> No need to do this.
>
>>   	pagevec_init(&pvec, 0);
>>
>>   	while (index <= end) {
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index 0052ae8..6afb56c 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -1167,6 +1167,16 @@ static inline block_t __start_sum_addr(struct f2fs_sb_info *sbi)
>>   	return le32_to_cpu(F2FS_CKPT(sbi)->cp_pack_start_sum);
>>   }
>>
>> +static inline block_t __start_main_addr(struct f2fs_sb_info *sbi)
>> +{
>> +	return le32_to_cpu(F2FS_RAW_SUPER(sbi)->main_blkaddr);
>> +}
>> +
>> +static inline block_t __start_sum_addr(struct f2fs_sb_info *sbi)
>> +{
>> +	return le32_to_cpu(F2FS_CKPT(sbi)->cp_pack_start_sum);
>> +}
>> +
>
> Ditto.
>
>>   static inline bool inc_valid_node_count(struct f2fs_sb_info *sbi,
>>   						struct inode *inode)
>>   {
>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
>> index 7bcbc6e..7d2b0bb 100644
>> --- a/fs/f2fs/node.c
>> +++ b/fs/f2fs/node.c
>> @@ -1161,7 +1161,7 @@ int sync_node_pages(struct f2fs_sb_info *sbi, nid_t ino,
>>   	pagevec_init(&pvec, 0);
>>
>>   next_step:
>> -	index = 0;
>> +	index = __start_main_addr(sbi);
>
> No, its index is for nid.
>
>>   	end = LONG_MAX;
>>
>>   	while (index <= end) {
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index bd7e9c6..d394711 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -1040,6 +1040,9 @@ static int read_raw_super_block(struct super_block *sb,
>>   	struct f2fs_super_block *super;
>>   	int err = 0;
>>
>> +	super = kzalloc(sizeof(struct f2fs_super_block), GFP_KERNEL);
>> +	if (!super)
>> +		return -ENOMEM;
>>   retry:
>>   	buffer = sb_bread(sb, block);
>>   	if (!buffer) {
>> @@ -1055,9 +1058,8 @@ retry:
>>   		}
>>   	}
>>
>> -	super = (struct f2fs_super_block *)
>> -		((char *)(buffer)->b_data + F2FS_SUPER_OFFSET);
>> -
>> +	memcpy(super, buffer->b_data + F2FS_SUPER_OFFSET,
>> +					sizeof(struct f2fs_super_block));
>>   	/* sanity checking of raw super */
>>   	if (sanity_check_raw_super(sb, super)) {
>>   		brelse(buffer);
>> @@ -1090,8 +1092,10 @@ retry:
>>
>>   out:
>>   	/* No valid superblock */
>> -	if (!*raw_super)
>> +	if (!*raw_super) {
>> +		kfree(super);
>>   		return err;
>> +	}
>
> Need to consider f2fs_commit_super and kfree() in put_super.

We also need to consider f2fs_fill_super error processing procedure:

@@ -1388,6 +1388,7 @@ free_options:
         kfree(options);
  free_sb_buf:
         brelse(raw_super_buf);
+       kfree(raw_super);
	
>
> Could you check out this patch?
>
> ---
>   fs/f2fs/super.c | 18 ++++++++++++++----
>   1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index dbf16ad..8541c93 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -567,6 +567,7 @@ static void f2fs_put_super(struct super_block *sb)
>
>   	sb->s_fs_info = NULL;
>   	brelse(sbi->raw_super_buf);
> +	kfree(sbi->raw_super);
>   	kfree(sbi);
>   }
>
> @@ -1040,6 +1041,9 @@ static int read_raw_super_block(struct super_block *sb,
>   	struct f2fs_super_block *super;
>   	int err = 0;
>
> +	super = kzalloc(sizeof(struct f2fs_super_block), GFP_KERNEL);
> +	if (!super)
> +		return -ENOMEM;
>   retry:
>   	buffer = sb_bread(sb, block);
>   	if (!buffer) {
> @@ -1055,8 +1059,7 @@ retry:
>   		}
>   	}
>
> -	super = (struct f2fs_super_block *)
> -		((char *)(buffer)->b_data + F2FS_SUPER_OFFSET);
> +	memcpy(super, buffer->b_data + F2FS_SUPER_OFFSET, sizeof(*super));
>
>   	/* sanity checking of raw super */
>   	if (sanity_check_raw_super(sb, super)) {
> @@ -1090,14 +1093,17 @@ retry:
>
>   out:
>   	/* No valid superblock */
> -	if (!*raw_super)
> +	if (!*raw_super) {
> +		kfree(super);
>   		return err;
> +	}
>
>   	return 0;
>   }
>
>   int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
>   {
> +	struct f2fs_super_block *super = F2FS_RAW_SUPER(sbi);
>   	struct buffer_head *sbh = sbi->raw_super_buf;
>   	struct buffer_head *bh;
>   	int err;
> @@ -1108,7 +1114,7 @@ int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
>   		return -EIO;
>
>   	lock_buffer(bh);
> -	memcpy(bh->b_data, sbh->b_data, sbh->b_size);
> +	memcpy(bh->b_data + F2FS_SUPER_OFFSET, super, sizeof(*super));
>   	WARN_ON(sbh->b_size != F2FS_BLKSIZE);
>   	set_buffer_uptodate(bh);
>   	set_buffer_dirty(bh);
> @@ -1124,6 +1130,10 @@ int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
>
>   	/* write current valid superblock */
>   	lock_buffer(sbh);
> +	if (memcmp(sbh->b_data + F2FS_SUPER_OFFSET, super, sizeof(*super))) {
> +		f2fs_msg(sbi->sb, KERN_INFO, "Write modified valid superblock");
> +		memcpy(sbh->b_data + F2FS_SUPER_OFFSET, super, sizeof(*super));
> +	}
>   	set_buffer_dirty(sbh);
>   	unlock_buffer(sbh);
>
>
It looks good to me, but can we releasing grabbed block buffer 'sbi->raw_super_buf'
as Chao Yu said.

Thanks.
Yunlei


------------------------------------------------------------------------------
