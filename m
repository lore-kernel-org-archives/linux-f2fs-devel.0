From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 1/7] f2fs: split free nid list
Date: Wed, 12 Oct 2016 09:14:25 +0800
Message-ID: <d3c11045-35bf-3d8c-52a2-924cb9dfd0fd@huawei.com>
References: <20161011143136.2107-1-chao@kernel.org>
 <20161011170902.GA82199@jaegeuk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161011170902.GA82199@jaegeuk>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

On 2016/10/12 1:09, Jaegeuk Kim wrote:
> Hi Chao,
> 
> On Tue, Oct 11, 2016 at 10:31:30PM +0800, Chao Yu wrote:
>> From: Chao Yu <yuchao0@huawei.com>
>>
>> During free nid allocation, in order to do preallocation, we will tag free
>> nid entry as allocated one and still leave it in free nid list, for other
>> allocators who want to grab free nids, it needs to traverse the free nid
>> list for lookup. It becomes overhead in scenario of allocating free nid
>> intensively by multithreads.
>>
>> This patch splits free nid list to two list: {free,alloc}_nid_list, to
>> keep free nids and preallocated free nids separately, after that, traverse
>> latency will be gone.
> 
> How about adding a list array like this?
> 
> enum {
> 	ALLOC_NID_LIST,
> 	FREE_NID_LIST,
> 	MAX_NID_LIST,
> };
> 
> struct list_head nid_list[MAX_NID_LIST];
> 
> Oh, there is another clean-up patch which defines this enum.
> IMO, it'd be good to write one patch including split and clean-up together.

OK, let me merge those patches as you reminded.

thanks,
