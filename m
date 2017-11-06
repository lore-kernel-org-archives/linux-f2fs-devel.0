From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 2/3] f2fs: trace checkpoint reason in fsync()
Date: Mon, 6 Nov 2017 11:10:33 +0800
Message-ID: <c3589040-15ce-9e8f-bb1c-26e881ae50af@huawei.com>
References: <20171105135330.15070-1-chao@kernel.org>
 <20171105135330.15070-2-chao@kernel.org>
 <20171106005541.GB49513@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171106005541.GB49513@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/11/6 8:55, Jaegeuk Kim wrote:
> On 11/05, Chao Yu wrote:
>> From: Chao Yu <yuchao0@huawei.com>
>>
>> This patch slightly changes need_do_checkpoint to return the detail
>> info that indicates why we need do checkpoint, then caller could print
>> it with trace message.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/file.c              | 34 ++++++++++++++++++----------------
>>  include/trace/events/f2fs.h | 12 ++++++------
>>  2 files changed, 24 insertions(+), 22 deletions(-)
>>
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index cee0f36ba9a1..d9d8b1c372f8 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -141,27 +141,29 @@ static int get_parent_ino(struct inode *inode, nid_t *pino)
>>  	return 1;
>>  }
>>  
>> -static inline bool need_do_checkpoint(struct inode *inode)
>> +static inline int need_do_checkpoint(struct inode *inode)
>>  {
>>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>> -	bool need_cp = false;
>> +	int cp_reason = 0;
>>  
>> -	if (!S_ISREG(inode->i_mode) || inode->i_nlink != 1)
>> -		need_cp = true;
>> +	if (!S_ISREG(inode->i_mode))
>> +		cp_reason = 1;
>> +	else if (inode->i_nlink != 1)
>> +		cp_reason = 2;
>>  	else if (is_sbi_flag_set(sbi, SBI_NEED_CP))
>> -		need_cp = true;
>> +		cp_reason = 3;
>>  	else if (file_wrong_pino(inode))
>> -		need_cp = true;
>> +		cp_reason = 4;
>>  	else if (!space_for_roll_forward(sbi))
>> -		need_cp = true;
>> +		cp_reason = 5;
>>  	else if (!is_checkpointed_node(sbi, F2FS_I(inode)->i_pino))
>> -		need_cp = true;
>> +		cp_reason = 6;
>>  	else if (test_opt(sbi, FASTBOOT))
>> -		need_cp = true;
>> +		cp_reason = 7;
>>  	else if (sbi->active_logs == 2)
>> -		need_cp = true;
>> +		cp_reason = 8;
> 
> We need to make the numbers by enum so that we could interpret them in tracepoint
> below.

Agreed, could you check v2? :)

Thanks,

> 
> Thanks,
> 
>>  
>> -	return need_cp;
>> +	return cp_reason;
>>  }
>>  
>>  static bool need_inode_page_update(struct f2fs_sb_info *sbi, nid_t ino)
>> @@ -196,7 +198,7 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
>>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>>  	nid_t ino = inode->i_ino;
>>  	int ret = 0;
>> -	bool need_cp = false;
>> +	bool cp_reason = 0;
>>  	struct writeback_control wbc = {
>>  		.sync_mode = WB_SYNC_ALL,
>>  		.nr_to_write = LONG_MAX,
>> @@ -215,7 +217,7 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
>>  	clear_inode_flag(inode, FI_NEED_IPU);
>>  
>>  	if (ret) {
>> -		trace_f2fs_sync_file_exit(inode, need_cp, datasync, ret);
>> +		trace_f2fs_sync_file_exit(inode, cp_reason, datasync, ret);
>>  		return ret;
>>  	}
>>  
>> @@ -246,10 +248,10 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
>>  	 * sudden-power-off.
>>  	 */
>>  	down_read(&F2FS_I(inode)->i_sem);
>> -	need_cp = need_do_checkpoint(inode);
>> +	cp_reason = need_do_checkpoint(inode);
>>  	up_read(&F2FS_I(inode)->i_sem);
>>  
>> -	if (need_cp) {
>> +	if (cp_reason) {
>>  		/* all the dirty node pages should be flushed for POR */
>>  		ret = f2fs_sync_fs(inode->i_sb, 1);
>>  
>> @@ -306,7 +308,7 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
>>  	}
>>  	f2fs_update_time(sbi, REQ_TIME);
>>  out:
>> -	trace_f2fs_sync_file_exit(inode, need_cp, datasync, ret);
>> +	trace_f2fs_sync_file_exit(inode, cp_reason, datasync, ret);
>>  	f2fs_trace_ios(NULL, 1);
>>  	return ret;
>>  }
>> diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
>> index 009745564214..f1a317e6db79 100644
>> --- a/include/trace/events/f2fs.h
>> +++ b/include/trace/events/f2fs.h
>> @@ -210,14 +210,14 @@ DEFINE_EVENT(f2fs__inode, f2fs_sync_file_enter,
>>  
>>  TRACE_EVENT(f2fs_sync_file_exit,
>>  
>> -	TP_PROTO(struct inode *inode, int need_cp, int datasync, int ret),
>> +	TP_PROTO(struct inode *inode, int cp_reason, int datasync, int ret),
>>  
>> -	TP_ARGS(inode, need_cp, datasync, ret),
>> +	TP_ARGS(inode, cp_reason, datasync, ret),
>>  
>>  	TP_STRUCT__entry(
>>  		__field(dev_t,	dev)
>>  		__field(ino_t,	ino)
>> -		__field(int,	need_cp)
>> +		__field(int,	cp_reason)
>>  		__field(int,	datasync)
>>  		__field(int,	ret)
>>  	),
>> @@ -225,15 +225,15 @@ TRACE_EVENT(f2fs_sync_file_exit,
>>  	TP_fast_assign(
>>  		__entry->dev		= inode->i_sb->s_dev;
>>  		__entry->ino		= inode->i_ino;
>> -		__entry->need_cp	= need_cp;
>> +		__entry->cp_reason	= cp_reason;
>>  		__entry->datasync	= datasync;
>>  		__entry->ret		= ret;
>>  	),
>>  
>> -	TP_printk("dev = (%d,%d), ino = %lu, checkpoint is %s, "
>> +	TP_printk("dev = (%d,%d), ino = %lu, cp_reason:%d, "
>>  		"datasync = %d, ret = %d",
>>  		show_dev_ino(__entry),
>> -		__entry->need_cp ? "needed" : "not needed",
>> +		__entry->cp_reason,
>>  		__entry->datasync,
>>  		__entry->ret)
>>  );
>> -- 
>> 2.14.1.145.gb3622a4ee
> 
> .
> 
