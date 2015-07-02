From: Chao Yu <yuchaochina@hotmail.com>
Subject: Re: [PATCH 1/2] f2fs: check the largest extent at
	look-up	time
Date: Thu, 2 Jul 2015 20:38:11 +0800
Message-ID: <COL402-EAS276860A94E32E730F8A4367AB970@phx.gbl>
References: <1435713946-6910-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchaochina@hotmail.com>) id 1ZAdl1-0006Ej-Gp
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 02 Jul 2015 12:38:23 +0000
Received: from col004-omc1s12.hotmail.com ([65.55.34.22])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZAdkz-0000S8-Nz
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 02 Jul 2015 12:38:23 +0000
In-Reply-To: <1435713946-6910-1-git-send-email-jaegeuk@kernel.org>
Content-Language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Wednesday, July 01, 2015 9:26 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org;
> linux-fsdevel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim; Jaegeuk Kim
> Subject: [f2fs-dev] [PATCH 1/2] f2fs: check the largest extent at look-up time
> 
> Because of the extent shrinker or other -ENOMEM scenarios, it cannot guarantee
> that the largest extent would be cached in the tree all the time.
> 
> Instead of relying on extent_tree, we can simply check the cached one in extent
> tree accordingly.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao2.yu@samsung.com>

------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
