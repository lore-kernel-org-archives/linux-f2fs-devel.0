From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] f2fs: support journelled quota
Date: Mon, 7 Aug 2017 16:40:28 +0800
Message-ID: <af032701-c125-ae0e-4922-98bf129549d2@huawei.com>
References: <20170725161502.13520-1-chao@kernel.org>
 <20170730073538.GB13058@jaegeuk-macbookpro.roam.corp.google.com>
 <470db7bc-10ad-9a74-e76d-29e07d782d99@kernel.org>
 <20170731210457.GA3993@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170731210457.GA3993@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

On 2017/8/1 5:04, Jaegeuk Kim wrote:
> On 07/30, Chao Yu wrote:
>> Hi Jaegeuk,
>>
>> On 2017/7/30 15:35, Jaegeuk Kim wrote:
>>> Hi Chao,
>>>
>>> When I add this patch, xfstests/fsstress are giving some weird kernel hang
>>> or panic now. Without only this patch, I can't see any problem. Can you review
>>> this patch one more time in terms of memory and lock usages.

Could you have a try with v3?

Thanks,
