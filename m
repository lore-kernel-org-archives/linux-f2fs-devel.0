From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: Data lost in Android app for not write new checkpoint
Date: Fri, 07 Aug 2015 17:50:21 +0800
Message-ID: <017201d0d0f6$9fa7f060$def7d120$@samsung.com>
References: <55BADD52.9060901@huawei.com>
	<01a401d0cb7e$bc483130$34d89390$@samsung.com>
	<55C0BB25.1070208@huawei.com>
	<012201d0d031$3baddf90$b3099eb0$@samsung.com>
	<55C44F8D.9030005@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZNeJN-00065o-Gw
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 07 Aug 2015 09:51:37 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZNeJL-0000FO-Cy
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 07 Aug 2015 09:51:37 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NSP02J4ZI1S04E0@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 07 Aug 2015 18:51:28 +0900 (KST)
In-reply-to: 
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'He YunLei' <heyunlei@huawei.com>
Cc: 'Jaegeuk Kim' <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

> Since we don't know when the data will be flushed and also what part of
> file will be flushed, at the time of abnormal pow-cut, the data/metadata
> of flushed file can be partial in device. So I don't think it's not

Should be:

of flushed file can be partial in device. So I don't think it's

My bad, sorry about that.

> possible for us to recover this kind of file with current fsync/recovery
> policy of f2fs.



------------------------------------------------------------------------------
