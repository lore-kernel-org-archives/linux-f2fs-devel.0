Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA32CA9EBB
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 12 Oct 2026 03:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oYQrh9xAiqNiM12+q3QE18UMFbTjk4Auevqu/InNq1c=; b=BauFjBIN7OqhW9ti118CeARTqa
	TgSY1v+arTWmd4nUF+4GnwReN9VRRmTgU1oB6KZU6gaaZorsjwfO8+TtPN7ZZRi3p0hKXceLIwkJL
	1ulKdR3VtuWajWkac03bU3Wv6OBaGyEBR9UDC3H3FdT/hsDlzDLAwS+c8blAVoOoD0E8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xG6iB-0002cl-Rf;
	Mon, 12 Oct 2026 03:28:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1xG6hy-0002cW-EU
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 03:28:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GHHdCBbvsJkfjljitJdjv/XMRgi7CMj6eI9DeUjJ3AM=; b=MxuEv7UV6Tmmd29m7VDCOkXsk7
 9mIH0xPI2YwoCDXU6rw7baiiWs1CM5n6yPJW4jLL6MANjkEJ49FrjIGWjnl2ECSb3tLIusqxg+Wmi
 wWZ1ycqOykTREjyKFwCJ06FqgNnL0Bt5fM9UgYQOu/Xq4aiGysmQQ0P1eRGcGswT1Edk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=GHHdCBbvsJkfjljitJdjv/XMRgi7CMj6eI9DeUjJ3AM=; b=Sqmt/VGwejZd5BHSFdbCADREra
 X1awxmC1CFORz4hewc89te6IloRij8AZtzU3Qt6uR/mQQRzDRmMGKXicvXmhcOav1CRJmxPVTxnEc
 OFCpVy6aTZh+jTzNPaEpUZQEYVjck/EyU7cIPNtOitT+oP8Kq6eDU1l/GdtPixhovT+k=;
Received: from m16.mail.126.com ([220.197.31.8])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xG6hv-00048i-2M for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 03:28:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=GH
 HdCBbvsJkfjljitJdjv/XMRgi7CMj6eI9DeUjJ3AM=; b=ZiXXKS7uHd3jvFOXou
 4SkbEl1R4CUgoRNMDpEbmKcmFPwUSqgiASSB0il1AdB22H430ju1FNhe7mkOm3AQ
 HAIi2Yhb5LqEGXenTkg89XncdYlu4e7WMZXBgA2KaT7AktbcDDSc07n7m4pfTizr
 qSuyoK4H8biD6BJGbYZvihGi4=
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn (unknown [])
 by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id
 _____wD3V9G0U8xq9Kp6BA--.43892S2; 
 Mon, 12 Oct 2026 11:27:48 +0800 (CST)
To: Barry Song <baohua@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Date: Mon, 12 Oct 2026 11:27:47 +0800
Message-ID: <20261012032747.1039225-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAGsJ_4y-9mmwjjb3UAb4=meONcn_SjYVgDuQJJ5QbdA-3Y=XeQ@mail.gmail.com>
References: <CAGsJ_4y-9mmwjjb3UAb4=meONcn_SjYVgDuQJJ5QbdA-3Y=XeQ@mail.gmail.com>
MIME-Version: 1.0
X-CM-TRANSID: _____wD3V9G0U8xq9Kp6BA--.43892S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RKa0mUUUUU
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBohTPn2rMU7S3rQAA39
X-Headers-End: 1xG6hv-00048i-2M
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: remove mappedtodisk flag usage in
 mmap write path
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Nanzhe Zhao via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Barry,

Thanks for the review. I have sent the patch v3 with the reworded commit message:

https://lore.kernel.org/linux-f2fs-devel/20261012030315.978375-1-zhaonanzhe@xiaomi.com/



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
