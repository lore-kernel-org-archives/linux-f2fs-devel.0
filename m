From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: add noinline_dentry mount option
Date: Sat, 27 Aug 2016 21:26:01 +0800
Message-ID: <0552f4e6-7374-fe39-b62d-764d1af0cdcc@kernel.org>
References: <20160826010122.79644-1-yuchao0@huawei.com>
 <20160826171113.GC88444@jaegeuk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160826171113.GC88444@jaegeuk>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

On 2016/8/27 1:11, Jaegeuk Kim wrote:
> Hi Chao,
> 
> I integrated this patch into the original patch which makes inline_dentry by
> default. And, I couldn't find any bug case from my test-cases. :)

OK, it seems that this feature becomes stable now. :)

Thanks,

> 
> Thanks,
> 
> On Fri, Aug 26, 2016 at 09:01:22AM +0800, Chao Yu wrote:
>> This patch adds noinline_dentry mount option.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  Documentation/filesystems/f2fs.txt | 1 +
>>  fs/f2fs/super.c                    | 7 +++++++
>>  2 files changed, 8 insertions(+)
>>
>> diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
>> index ecd8080..753dd4f 100644
>> --- a/Documentation/filesystems/f2fs.txt
>> +++ b/Documentation/filesystems/f2fs.txt
>> @@ -131,6 +131,7 @@ inline_dentry          Enable the inline dir feature: data in new created
>>                         directory entries can be written into inode block. The
>>                         space of inode block which is used to store inline
>>                         dentries is limited to ~3.4k.
>> +noinline_dentry        Diable the inline dentry feature.
>>  flush_merge	       Merge concurrent cache_flush commands as much as possible
>>                         to eliminate redundant command issues. If the underlying
>>  		       device handles the cache_flush command relatively slowly,
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index 7974833..b776414 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -87,6 +87,7 @@ enum {
>>  	Opt_inline_xattr,
>>  	Opt_inline_data,
>>  	Opt_inline_dentry,
>> +	Opt_noinline_dentry,
>>  	Opt_flush_merge,
>>  	Opt_noflush_merge,
>>  	Opt_nobarrier,
>> @@ -118,6 +119,7 @@ static match_table_t f2fs_tokens = {
>>  	{Opt_inline_xattr, "inline_xattr"},
>>  	{Opt_inline_data, "inline_data"},
>>  	{Opt_inline_dentry, "inline_dentry"},
>> +	{Opt_noinline_dentry, "noinline_dentry"},
>>  	{Opt_flush_merge, "flush_merge"},
>>  	{Opt_noflush_merge, "noflush_merge"},
>>  	{Opt_nobarrier, "nobarrier"},
>> @@ -488,6 +490,9 @@ static int parse_options(struct super_block *sb, char *options)
>>  		case Opt_inline_dentry:
>>  			set_opt(sbi, INLINE_DENTRY);
>>  			break;
>> +		case Opt_noinline_dentry:
>> +			clear_opt(sbi, INLINE_DENTRY);
>> +			break;
>>  		case Opt_flush_merge:
>>  			set_opt(sbi, FLUSH_MERGE);
>>  			break;
>> @@ -879,6 +884,8 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
>>  		seq_puts(seq, ",noinline_data");
>>  	if (test_opt(sbi, INLINE_DENTRY))
>>  		seq_puts(seq, ",inline_dentry");
>> +	else
>> +		seq_puts(seq, ",noinline_dentry");
>>  	if (!f2fs_readonly(sbi->sb) && test_opt(sbi, FLUSH_MERGE))
>>  		seq_puts(seq, ",flush_merge");
>>  	if (test_opt(sbi, NOBARRIER))
>> -- 
>> 2.8.2.311.gee88674
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
