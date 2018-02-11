From: heyunlei <heyunlei@huawei.com>
Subject: Re: [PATCH] f2fs: remove unneed reada during build free
 nids
Date: Sun, 11 Feb 2018 01:55:07 +0000
Message-ID: <42B685BFA705F94C860C6DD0752F05654832E9FF@DGGEMA503-MBX.china.huawei.com>
References: <1518148722-31212-1-git-send-email-heyunlei@huawei.com>
 <eb931c4a-7d7b-22f8-0ef8-ddd2fa880781@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.194]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <heyunlei@huawei.com>) id 1ekgrV-0004pf-6t
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 11 Feb 2018 01:55:25 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188] helo=huawei.com)
 by sfi-mx-4.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1ekgrT-0001ll-Vb
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 11 Feb 2018 01:55:25 +0000
In-Reply-To: <eb931c4a-7d7b-22f8-0ef8-ddd2fa880781@kernel.org>
Content-Language: zh-CN
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao@kernel.org>, "jaegeuk@kernel.org" <jaegeuk@kernel.org>, "Yuchao (T)" <yuchao0@huawei.com>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>



>-----Original Message-----
>From: Chao Yu [mailto:chao@kernel.org]
>Sent: Friday, February 09, 2018 9:37 PM
>To: heyunlei; jaegeuk@kernel.org; Yuchao (T); linux-f2fs-devel@lists.sourceforge.net
>Subject: Re: [f2fs-dev] [PATCH] f2fs: remove unneed reada during build free nids
>
>On 2018/2/9 11:58, Yunlei He wrote:
>> This patch remove unneed reada during build free nids.
>> If few nids left, three will introduce a lot of no hit
>> read io.
>
>I guess it is due to be lack of commit c1fe3e981440 ("Revert "f2fs:
>reuse nids more aggressively""), before that commit, we will update
>.next_scan_nid randomly instead of updating it ascendingly, then
>during __build_free_nids we may readahead NAT pages starting from
>random position.

I think commit c1fe3e981440 will reduce fragment of nat area, it
will locate all used nids at the left head of nat area, which I think
will do benefit to WA ?

e.g, if we have used 10000 nids, which will hold 10000/455 blocks at least.
Without this commit, the blocks taken for nids will expansion, may be 10000
blocks in the worst case, at this time, if we update node info, we will produce 
more nat IOs?

>
>Could try that commit to check IO again?
>
>Thanks,
------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
