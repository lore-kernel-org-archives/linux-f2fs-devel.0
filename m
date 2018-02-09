From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: remove unneed reada during build free
 nids
Date: Fri, 9 Feb 2018 21:36:36 +0800
Message-ID: <eb931c4a-7d7b-22f8-0ef8-ddd2fa880781@kernel.org>
References: <1518148722-31212-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <chao@kernel.org>) id 1ek8rJ-00064L-I7
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 09 Feb 2018 13:36:57 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1ek8rI-0005vz-SW
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 09 Feb 2018 13:36:57 +0000
In-Reply-To: <1518148722-31212-1-git-send-email-heyunlei@huawei.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Yunlei He <heyunlei@huawei.com>, jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net

On 2018/2/9 11:58, Yunlei He wrote:
> This patch remove unneed reada during build free nids.
> If few nids left, three will introduce a lot of no hit
> read io.

I guess it is due to be lack of commit c1fe3e981440 ("Revert "f2fs:
reuse nids more aggressively""), before that commit, we will update
.next_scan_nid randomly instead of updating it ascendingly, then
during __build_free_nids we may readahead NAT pages starting from
random position.

Could try that commit to check IO again?

Thanks,

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
