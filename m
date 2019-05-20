From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2 1/1] f2fs: ioctl for removing a range from F2FS
Date: Mon, 20 May 2019 20:05:35 +0800
Message-ID: <ce0b747e-6e3d-6285-7f20-f4ecd6c4df6c@huawei.com>
References: <20190517021647.43083-1-sunqiuyang@huawei.com>
 <20190517025628.GF31704@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190517025628.GF31704@bombadil.infradead.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Wilcox <willy@infradead.org>, sunqiuyang <sunqiuyang@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, miaoxie@huawei.com, fangwei1@huawei.com, stummala@codeaurora.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2019/5/17 10:56, Matthew Wilcox wrote:
> On Fri, May 17, 2019 at 10:16:47AM +0800, sunqiuyang wrote:
>> +++ b/fs/f2fs/f2fs.h
>> @@ -423,6 +423,8 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
>>  #define F2FS_IOC_SET_PIN_FILE		_IOW(F2FS_IOCTL_MAGIC, 13, __u32)
>>  #define F2FS_IOC_GET_PIN_FILE		_IOR(F2FS_IOCTL_MAGIC, 14, __u32)
>>  #define F2FS_IOC_PRECACHE_EXTENTS	_IO(F2FS_IOCTL_MAGIC, 15)
>> +#define F2FS_IOC_SHRINK_RESIZE		_IOW(F2FS_IOCTL_MAGIC, 16,	\
>> +						struct f2fs_resize_param)
> 
> Why not match ext4?
> 
> fs/ext4/ext4.h:#define EXT4_IOC_RESIZE_FS               _IOW('f', 16, __u64)

Agreed, Qiuyang, could you consider to implement this interface as ext4's, in
addition, changing parameter from shrunk bytes to new block count of fs?

F2FS_IOC_RESIZE_FS		_IOW('f', 16, __u64)

if (copy_from_user(&block_count, (__u64 __user *)arg, sizeof(__u64)))

Thanks,

> 
> .
> 
