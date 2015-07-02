From: Chao Yu <yuchaochina@hotmail.com>
Subject: Re: [PATCH 11/12] f2fs: add noextent_cache mount option
Date: Thu, 2 Jul 2015 20:35:34 +0800
Message-ID: <COL402-EAS3119D4AFA99D9454639B68CAB970@phx.gbl>
References: <1435603176-63219-1-git-send-email-jaegeuk@kernel.org>
	<1435603176-63219-11-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchaochina@hotmail.com>) id 1ZAdiX-0003i4-Hs
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 02 Jul 2015 12:35:49 +0000
Received: from col004-omc1s17.hotmail.com ([65.55.34.27])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZAdiW-0006YM-Oi
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 02 Jul 2015 12:35:49 +0000
In-Reply-To: <1435603176-63219-11-git-send-email-jaegeuk@kernel.org>
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
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Tuesday, June 30, 2015 2:40 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim
> Subject: [f2fs-dev] [PATCH 11/12] f2fs: add noextent_cache mount option
> 
> This patch adds noextent_cache mount option.

How about adding some descriptions in Documentation to help our user?

The other thing is we'd better to show 'noextent_cache' option when user
lookups the mount options.

How about adding codes as below?
if (test_opt(sbi, EXTENT_CACHE))
	seq_puts(seq, ",extent_cache");
+else
+	seq_puts(seq, ",noextent_cache");

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

The other looks good to me, so please add:

Reviewed-by: Chao Yu <chao2.yu@samsung.com>

------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
