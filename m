From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: Fix deadlock in shutdown ioctl
Date: Wed, 16 May 2018 14:48:42 +0800
Message-ID: <67bd2926-6851-0544-c24a-85dfa72aa70f@huawei.com>
References: <1525958444-5579-1-git-send-email-stummala@codeaurora.org>
 <de6f040b-81d3-7f52-2482-135d11200788@huawei.com>
 <20180515075747.GA6293@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180515075747.GA6293@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sahitya Tummala <stummala@codeaurora.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/5/15 15:57, Sahitya Tummala wrote:
> On Mon, May 14, 2018 at 11:39:42AM +0800, Chao Yu wrote:
>> On 2018/5/10 21:20, Sahitya Tummala wrote:
>>> f2fs_ioc_shutdown() ioctl gets stuck in the below path
>>> when going down with full sync (F2FS_GOING_DOWN_FULLSYNC)
>>> option.
>>>
>>> __switch_to+0x90/0xc4
>>> percpu_down_write+0x8c/0xc0
>>> freeze_super+0xec/0x1e4
>>> freeze_bdev+0xc4/0xcc
>>> f2fs_ioctl+0xc0c/0x1ce0
>>> f2fs_compat_ioctl+0x98/0x1f0
>>>
>>> Fix this by not holding write access during this ioctl.
>>
>> I think we can just remove lock coverage for F2FS_GOING_DOWN_FULLSYNC path, for
>> other path, we need to keep as it is.
>>
> 
> Thanks, I thought about it too but then I checked that XFS shutdown ioctl is
> not taking any lock for this ioctl. Hence, I followed the same in F2FS.
> Do you know why XFS is not taking any lock? 

I don't know. :(

> Is it really needed in shutdown ioctl?

IMO, yes, we should keep freeze and remount be aware of the shutdown operation.

Thanks,

> 
> --
> Sent by a consultant of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
> 
> 
