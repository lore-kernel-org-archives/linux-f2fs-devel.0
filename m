From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] Revert "f2fs: use printk_ratelimited for f2fs_msg"
Date: Tue, 14 Aug 2018 15:53:11 +0800
Message-ID: <c59c6667-b532-42a6-2e61-752d7aba9001@huawei.com>
References: <20180813062845.25394-1-yuchao0@huawei.com>
 <a5f29d4ed6098373fb3fe7a0194687d78d3592f7.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a5f29d4ed6098373fb3fe7a0194687d78d3592f7.camel@perches.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Joe, thanks for pointing out this, I didn't see any cases need to be limited now.

Thanks,

On 2018/8/13 17:50, Joe Perches wrote:
> On Mon, 2018-08-13 at 14:28 +0800, Chao Yu wrote:
>> Don't limit printing log, so that we will not miss any key messages.
>>
>> This reverts commit a36c106dffb616250117efb1cab271c19a8f94ff.
> []
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> []
>> @@ -209,7 +209,7 @@ void f2fs_msg(struct super_block *sb, const char *level, const char *fmt, ...)
>>  	va_start(args, fmt);
>>  	vaf.fmt = fmt;
>>  	vaf.va = &args;
>> -	printk_ratelimited("%sF2FS-fs (%s): %pV\n", level, sb->s_id, &vaf);
>> +	printk("%sF2FS-fs (%s): %pV\n", level, sb->s_id, &vaf);
>>  	va_end(args);
>>  }
> 
> If there was value in ratelimiting these messages at all,
> perhaps there is value in using a specific ratelimit_state
> other than
> 
> 	static DEFINE_RATELIMIT_STATE(_rs,				\
> 				      DEFAULT_RATELIMIT_INTERVAL,	\
> 				      DEFAULT_RATELIMIT_BURST);		\
> 
> 
> 
> 
> .
> 
