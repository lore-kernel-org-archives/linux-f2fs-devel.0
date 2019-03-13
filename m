From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v11] f2fs: guarantee journalled quota data by checkpoint
Date: Wed, 13 Mar 2019 09:17:42 +0800
Message-ID: <d87fbaf6-8291-0629-4555-f2687e1d890c@huawei.com>
References: <20180920120500.21026-1-chao@kernel.org>
 <7a2b9277-acbf-eda4-d043-74463d7b61c7@huawei.com>
 <20190312182855.GA45421@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190312182855.GA45421@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Weichao Guo <guoweichao@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2019/3/13 2:28, Jaegeuk Kim wrote:
> On 03/06, Chao Yu wrote:
>> Hi Jaegeuk,
>>
>> On 2018/9/20 20:05, Chao Yu wrote:
>>> @@ -3456,3 +3477,16 @@
>>>
>>>  extern void f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned int rate,
>>>
>>> #endif
>>> #endif
>>> +
>>> +static inline bool is_journalled_quota(struct f2fs_sb_info *sbi)
>>> +{
>>> +#ifdef CONFIG_QUOTA
>>> + if (f2fs_sb_has_quota_ino(sbi->sb))
>>> + return true;
>>> + if (F2FS_OPTION(sbi).s_qf_names[USRQUOTA] ||
>>> + F2FS_OPTION(sbi).s_qf_names[GRPQUOTA] ||
>>> + F2FS_OPTION(sbi).s_qf_names[PRJQUOTA])
>>> + return true;
>>> +#endif
>>> + return false;
>>> +}
>>
>> I checked dev branch, and found one patch we didn't send to mailing list,
>> could you please send it out?
>>
>> f2fs: fix wrong #endif
>>
>> I think my quota patch caused this 'wrong #endif' issue, could you add
>> single line comment to notice which #if the last #endif is corresponding
>> to? so that we can avoid same mistake as quota patch made.
> 
> Ah, I forgot to post the patch. It's quite late but obvious, and thus let me
> keep the patch as is in order to avoid messing up the commit history.

Okay, let me add one other patch for that. :)

Thanks,

> 
> Thanks,
> 
> .
> 
