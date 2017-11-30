From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: remove a redundant conditional
 expression
Date: Thu, 30 Nov 2017 15:07:24 +0800
Message-ID: <8179406b-46dc-a97c-34cf-76d0fd848f11@huawei.com>
References: <CGME20171128121829epcas5p1d7a840229243b79f5b82d56d0b4dc38d@epcas5p1.samsung.com>
 <000b01d36842$fed887d0$fc899770$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eKIwa-0007cm-Uh
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Nov 2017 07:07:36 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eKIwZ-0001Vl-DP
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Nov 2017 07:07:36 +0000
In-Reply-To: <000b01d36842$fed887d0$fc899770$@samsung.com>
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
To: LiFan <fanofcode.li@samsung.com>, 'Chao Yu' <chao@kernel.org>, 'Jaegeuk
 Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2017/11/28 20:17, LiFan wrote:
> Avoid checking is_inode repeatedly, and make the logic 
> a little bit clearer.
> 
> Signed-off-by: Fan li <fanofcode.li@samsung.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
