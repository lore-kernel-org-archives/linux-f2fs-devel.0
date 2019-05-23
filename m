From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add missing sysfs entries in
 documentation
Date: Thu, 23 May 2019 22:14:53 +0800
Message-ID: <fc1eda2c-1d31-749f-03ef-eed152fb42c0@kernel.org>
References: <20190521180606.10461-1-jaegeuk@kernel.org>
 <20190522175035.GB81051@jaegeuk-macbookpro.roam.corp.google.com>
 <14672901-54a2-120f-a2ce-52f7d6fb3008@kernel.org>
 <20190523140649.GA10954@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190523140649.GA10954@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2019-5-23 22:06, Jaegeuk Kim wrote:
> On 05/23, Chao Yu wrote:
>> On 2019-5-23 1:50, Jaegeuk Kim wrote:
>>> This patch cleans up documentation to cover missing sysfs entries.
>>>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>
>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
>>
>>> + reserved_blocks	      This parameter indicates the number of blocks that
>>> +			      f2fs reserves internally for root.
>>> +
>>
>> I mean we can move below entry here.
> 
> Ah, I'd like to keep the order defined in sysfs.c.

No problem. :)

Thanks,

> 
>>
>> current_reserved_blocks	      This shows # of blocks currently reserved.
>>
>>> + reserved_blocks	      This shows # of blocks currently reserved.
>>
>> Thanks,
