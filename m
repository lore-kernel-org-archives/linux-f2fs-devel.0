From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: Re: [PATCH 3/4] f2fs: use find_next_bit_le rather than test_bit_le
 in, find_in_block
Date: Mon, 7 Jul 2014 10:13:53 +0800
Message-ID: <53BA0261.9070101@cn.fujitsu.com>
References: <53A950F9.907@cn.fujitsu.com> <20140702103059.GA26619@jmac.local> <53B52CEA.8080407@cn.fujitsu.com> <20140704053619.GA32528@jmac.local> <001301cf9750$5e897bc0$1b9c7340$@samsung.com> <53B65FF9.9030204@cn.fujitsu.com> <20140705062535.GA35486@jmac.local> <20140707014500.GA31954@cm224.lee>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20140707014500.GA31954@cm224.lee>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Changman Lee <cm224.lee@samsung.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao2.yu@samsung.com>, 'f2fs' <linux-f2fs-devel@lists.sourceforge.net>, 'fsdevel' <linux-fsdevel@vger.kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Changman,
On 07/07/2014 09:45 AM, Changman Lee wrote:

> Hello,
> 
> On Fri, Jul 04, 2014 at 11:25:35PM -0700, Jaegeuk Kim wrote:
>> To Changman,
>>
>> Just for sure, can you reproduce this issue in the x86 machine with proper
>> benchmarks? (i.e., test_bit_le vs. find_next_bit_le)
> 
> It shows quite a different result of bit_mod_test between server and desktop.

It is possible. And the trend of the result is correct, so I think it is credible.

> 
> CPU i5 x86_64 Ubuntu Server - 3.16.0-rc3
> 
> [266627.204776] find_next_bit_le    test_bit_le
> [266627.205319]     1832                1774
> [266627.206223]     1292                1746
> [266627.207092]     1205                1746
> [266627.207876]      914                1746
> [266627.208710]     1082                1746
> [266627.209506]      956                1746
> [266627.210175]      523                1746
> 
> [266627.211839]     3907                1746
> [266627.212898]     1850                1746
> [266627.214046]     2153                1746
> [266627.215118]     1894                1746
> 
> 
> CPU i7 x86_64 Mint Desktop - 3.13.0-24-generic
> 
> [432284.422356] find_next_bit_le    test_bit_le
> [432284.423470]     3771                3878
> [432284.425400]     2671                3696
> [432284.427221]     2492                3760
> [432284.428908]     1971                3696
> [432284.430640]     2191                3730
> [432284.432323]     1986                3696
> [432284.433741]     1123                3698
> 
> [432284.437269]     8299                3696
> [432284.439487]     3842                3696
> [432284.441850]     4334                3696
> [432284.444080]     3885                3696
> 
>>
>> To all,
>>
>> I cautiously suspect that the performances might be different when processing
>> f2fs_find_entry, since L1/L2 cache misses due to the intermediate routines like
>> matching strings can make some effect on it.
>>
>> But, IMO, it is still worth to investigate this issue and contemplate how to
>> detect all ones or not.
>>
>> Ah, one solution may be using 2 bytes from the reserved space, total 3, to
>> indicate how many valid dentries are stored in the dentry block.
>>
>> Any ideas?
> 
> Agree. In the case of one bits is over than half, test_bit is better
> than find_next_bit. So we can decide whether using test_bit or
> find_next_bit depending on count of one bits.
> 
> When just comparing test_bit and find_next_bit, I think test_bit is more effective
> in f2fs because let's think about f2fs's dentry management policy.
> One dentry bucket is filled then next dentry bucket is filled from
> lower to higher level. If empty slots of lower level exist, they are used first.
> So, I guess that one bits are getting more than zero bits as time goes by.

Partly agree.
IMO, what we seriously care about is *find a suitable slot*, not counting the
bitmap, we can gain more benefit from find_next_bit rather than test_bit, not only
the efficiency, but also the readability.

Thanks,
Gu

> 
> Thanks,
> 
>>
>> Thanks,
>>


