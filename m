Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99281C44506
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 Jul 2026 01:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z4nWST8exwMV0ax+79jqoC92V+H5FSViiNO+XX2Q5Gc=; b=c+szajoqS/Y4X6p1j0BiDt/QTB
	vo4imasVS2pjI49pHGnRvMPp1hnU5IsrSXSjW3K++EjkNkKuo0nNbn1cTtZmy9vyA1W9sUV1Do1gu
	eU/fFmFu6Jam1QfPcAxNVZlJODn3UsTS9/M0rzsXqp3Q4TpzoGrwJDI84d+tPLyVVfZw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1whzr1-0001R5-V8;
	Fri, 10 Jul 2026 01:16:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1whzr0-0001Qp-PJ
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Jul 2026 01:16:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IRP3vfvoLaBR0x+trbaoJtWwSSnfpSriCDu2or8rvxc=; b=bdijxuZIRkynEmOWoYal/9pzsr
 GC9B6h4cEP5SZm0f20RiHPCGO3eKfRAfGuZ/psx4OpitONPdix+09tbWgkg7mwzwPzxkuzwWAjRVC
 Se3F7IC54o5R4qkNrb18uZtMgdCQuuxx1KKagXII7DutYwqFs62YSqA74xLdAS784fPg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=IRP3vfvoLaBR0x+trbaoJtWwSSnfpSriCDu2or8rvxc=; b=AjPzqRIoxBuzo+tj7foTVZoYym
 hDzIvQNzTO6G8dYGkV4VNeCXDY+Btgx0QlewUKB4syz5VTXzhbtzdZ1XIcd0qeyjUf7LIo4moqBU6
 yS0xyS/6ym3j4rgcf2eiCfgbQitY3bhZA+xs7hxkvG+vdxcXslEWnW0TPzpn158I7UTE=;
Received: from m16.mail.126.com ([220.197.31.7])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1whzqh-0004wG-NF for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Jul 2026 01:16:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=IR
 P3vfvoLaBR0x+trbaoJtWwSSnfpSriCDu2or8rvxc=; b=XjCCxOk090qAEnhkJ0
 eqvuOeK5Sh8F5tKy3e7LX/4eA8KAPxoEBkihWn55+ZMkMfz3tCp5Rn1Bvd5AYrUM
 Ggph66+gEZ0RFTu/uMBpaUe9gbnbqwTSCZPUQkN9UD4/tnGE38PXQNe0ISe7hFNB
 kf9w2McGntOkNXE8fILikg6jI=
Received: from YLLaptop.. (unknown [])
 by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id
 _____wD3p+G2R1Bq0M_wDA--.7522S2; 
 Fri, 10 Jul 2026 09:15:36 +0800 (CST)
To: Chao Yu <chao@kernel.org>
Date: Fri, 10 Jul 2026 09:15:32 +0800
Message-Id: <20260710011534.2307696-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <bc4b29f0-8309-4a36-bdbe-b5f375aec31a@kernel.org>
References: <bc4b29f0-8309-4a36-bdbe-b5f375aec31a@kernel.org>
MIME-Version: 1.0
X-CM-TRANSID: _____wD3p+G2R1Bq0M_wDA--.7522S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUeiihUUUUU
X-Originating-IP: [39.144.78.103]
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBohiufmpQR7je3QAA3s
X-Headers-End: 1whzqh-0004wG-NF
Subject: Re: [f2fs-dev] [RFC PATCH v2 02/10] f2fs: carry subpage offset and
 count in write IO
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
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Dev Jain <Dev.Jain@arm.com>,
 linux-kernel@vger.kernel.org, David Hildenbrand <David.Hildenbrand@arm.com>,
 Bo Zhang <zhangbo56@xiaomi.com>, Kalesh Singh <kaleshsingh@google.com>,
 Ryan Roberts <Ryan.Roberts@arm.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

> How about cleaning up w/ below macros?
> 
> #define F2FS_FOLIO_INDEX(folio, fio)    (folio->index + fio->folio_offset)
> #define F2FS_FOLIO_BLKCNT(fio)          (fio->folio_blkcnt ? fio->folio_blkcnt : 1)

F2FS_FOLIO_XXX naming seems a bit weird to me :). It does not show that
we want to use the folio subpage index associated with fio, or the blkcnt
recorded in fio. I think names like F2FS_FIO_LBLK and F2FS_FIO_BLKCNT
may be better?



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
