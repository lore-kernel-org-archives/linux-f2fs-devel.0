From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v4] f2fs: obsolete free nid list approach
Date: Mon, 18 Dec 2017 19:56:08 +0800
Message-ID: <efa09a49-3e18-acd3-7deb-de543db5e550@huawei.com>
References: <20171130113112.50058-1-yuchao0@huawei.com>
 <20171201073637.GC86192@jaegeuk-macbookpro.roam.corp.google.com>
 <2cb36fd5-462d-d415-5f0c-871272480813@huawei.com>
 <20171214192156.GA35234@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171214192156.GA35234@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/12/15 3:21, Jaegeuk Kim wrote:
> On 12/11, Chao Yu wrote:
>> Hi Jaegeuk,
>>
>> On 2017/12/1 15:36, Jaegeuk Kim wrote:
>>> Hi Chao,
>>>
>>> This is really hard to review and risky a lot to apply it shortly. Do we have a
>>
>> I can understand your concern.
>>
>>> strong reason we have to do this? The original design goal was to minimize
>>> allocation delay which is almost zero for now. Of course, I agreed that there'd
>>
>> I agreed, For nid allocation performance there will be no room to improve since
>> we have already used memory to exchange performance there.
>>
>> After applying this patch, I can encounter slight regression in scenario of
>> continuous file creation.
>>
>> Anyway, goal of this patch is not aiming at performance, instead, it intends to
>> reduce code complexity, and maybe, slightly improving performance of allocation
>> in low-memory environment. So actually, this is a trade-off problem.
>>
>> If we decide to use old approach, I think what can be improved is that if we run
>> out-of-memory, we can switch to nid bitmap searching in alloc_nid rather than
>> preloading free nid entry in build_free_nid whose performance is memory sensitive.
>> Thoughts?
> 
> Hmm, in terms of performance, do we really suffer from memory pressure when
> preloading free nids?

Sorry for late reply, I'm on trip now. I guess it will, let me emulate low
memory environment, and do intensive allocation test, will report to you if
there is any progress.

Thanks,
