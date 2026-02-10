Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E77EEA3F2A
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 10 Feb 2026 08:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:To:Date:Message-ID:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Zk6Ubkjngi7fJ3BjL5npYvJ5fgQ5GQTUE5e/mS3f5sg=; b=mckM8mxH7hkIGphniULySwQKYB
	lt5VlQJ7+AB7jdBrNBfASn939FGbnNrnnKv8GPIQHFgcHiArAvE9L/6Jc9VMFAITWR6KxQ6iF5rJe
	Rk/MCwUmmWi4ewJF6V5GOOsAWNsz9jTZt/arxoS8WdAeQjVnWMWxECDERd7icFMFZKp8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vpjZp-0000pi-NS;
	Tue, 10 Feb 2026 08:58:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <mikolaj.rak@venturex.pl>) id 1vpjZo-0000pa-D4
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Feb 2026 08:58:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Subject:To:From:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=86VIaF2unP4vg5OpX+J8tHPXWoQ8hu3kSDMcmnIkxvQ=; b=TAbH2sU0Kdndyxk9FdQgWd7lp7
 oqzVqol+NrjjHd+XiGeSAE/EY3ryopx0c9Yd4s1eFBblkY9/QMU/+2IuuJI5HY32mICzmFBAW3eOp
 AOUO5hIqtYHmnZkmKHfV4FDmM9PmPJl3Ht99XOA59TNmn7IbPbdl7KKsGVisAfOKYn0Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:To:From:Date:
 Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=86VIaF2unP4vg5OpX+J8tHPXWoQ8hu3kSDMcmnIkxvQ=; b=g
 9GyxH/kK5TYdYA27WNng2xsseT5F8eib3HoaF21XxAxyYH7EF57vWmdElZIdF6Aj3BxgLDJ8s21dD
 CH0ecCQ7LAV06nOymS8xuaQJOWeI1PN5C/Bx7eR/qI8bQllvjWcp2ytB3T8p5WollW3GuOkPaM4RG
 vCyDVXgFGiEfATBY=;
Received: from mail.venturex.pl ([141.95.86.206])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vpjZn-00005Y-UZ for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Feb 2026 08:58:32 +0000
Received: by mail.venturex.pl (Postfix, from userid 1002)
 id A78D124C53; Tue, 10 Feb 2026 09:58:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=venturex.pl; s=mail;
 t=1770713905; bh=86VIaF2unP4vg5OpX+J8tHPXWoQ8hu3kSDMcmnIkxvQ=;
 h=Date:From:To:Subject:From;
 b=ZSS11cCr8JzGca1fv9cDH/84IACMFBoLTWOZNHjVOI9E+cpy1r1yjHevFF3MOWX9C
 3nEkjbtAMJh/99bv5U6YKVHwkcDJGDh5ZaoMDqQy413Dl+W5SbVNorQGZvwgyJj32j
 7BtywGcd+iZpJJ89LVGCltv0F2GIhv/fHTFbBh3Kir8Fto7qFS1hwcTxU501xfmpq0
 6Y3/3wVg7DTJpp5jZQqS6O+aEtrYMYiEY9nRRjI7SHZBPDp7k72K+w5SGqXBWlcbxh
 NUtvFyBdBaVt57RV6M5jxDUfJf5NzHxUET8AqWBLCuw/2kmM5F1pYT8/QbeEfUNReP
 rABncFDYbVI0Q==
Received: by mail.venturex.pl for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 10 Feb 2026 08:56:13 GMT
Message-ID: <20260210084552-0.1.cl.2le1q.0.idqlp6htby@venturex.pl>
Date: Tue, 10 Feb 2026 08:56:13 GMT
To: <linux-f2fs-devel@lists.sourceforge.net>
X-Mailer: mail.venturex.pl
MIME-Version: 1.0
X-Headers-End: 1vpjZn-00005Y-UZ
Subject: [f2fs-dev] Fundacja Rodzina a optymalizacja podatkowa
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
From: =?UTF-8?Q? Miko=C5=82aj_Rak ?= via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: =?UTF-8?Q? Miko=C5=82aj_Rak ?= <mikolaj.rak@venturex.pl>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

U3phbm93bmkgUGHFhHN0d28sCgpjenkgYnlsaWJ5IFBhxYRzdHdvIHphaW50ZXJlc293YW5pIHJv
em1vd8SFIG8gbW/FvGxpd3ljaCByb3p3acSFemFuaWFjaCBkbGEgc3dvamVqIGZpcm15IGkgcm9k
emlueT8KCk5vd2VsaXphY2phIHVzdGF3eSBvIEZ1bmRhY2phY2ggUm9kemlubnljaCBvdHdpZXJh
IHByemVkIHByemVkc2nEmWJpb3JjYW1pIHp1cGXFgm5pZSBub3dlIG1vxbxsaXdvxZtjaSBvY2hy
b255IG1hasSFdGt1IGkgcGxhbm93YW5pYSBzdWtjZXNqaS4gRnVuZGFjamEgUm9kemlubmEgcG96
d2FsYSBvZGR6aWVsacSHIGFrdHl3YSBvZCByeXp5ayBiaXpuZXNvd3ljaCwgcHJhd255Y2ggaSBw
b2RhdGtvd3ljaCwgYSBqZWRub2N6ZcWbbmllIHphY2hvd2HEhyBrb250cm9sxJkgbmFkIHN3b2lt
IG1hasSFdGtpZW0gaSB6YWRiYcSHIG8gamVnbyB0cndhxYJvxZvEhyBkbGEga29sZWpueWNoIHBv
a29sZcWELgoKQ28gaXN0b3RuZSwgcG8gdXDFgnl3aWUgMTAgbGF0IG9kIHduaWVzaWVuaWEgYWt0
eXfDs3cgZG8gZnVuZGFjamksIHJvc3pjemVuaWEgbyB6YWNob3dlayBwcnplc3RhasSFIG9ib3dp
xIV6eXdhxIcuIFVzdGF3b2Rhd2NhIHByemV3aWR6aWHFgiByw7N3bmllxbwgbGljem5lIHp3b2xu
aWVuaWEgcG9kYXRrb3dlIG9iZWptdWrEhWNlIG0uaW4uIGRvY2hvZHkgeiBkemlhxYJhbG5vxZtj
aSBnb3Nwb2RhcmN6ZWogY3p5IHd5bmFqZW0gbmllcnVjaG9tb8WbY2kuCgpCxJlkxJkgd2R6acSZ
Y3pueSB6YSBpbmZvcm1hY2rEmSwgY3p5IGNoY2llbGlieSBQYcWEc3R3byBwb3puYcSHIG1vxbxs
aXdvxZvEhyBzdHdvcnplbmlhIEZ1bmRhY2ppIFJvZHppbm5laj8KCgpQb3pkcmF3aWFtCk1pa2/F
gmFqIFJhawoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291
cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZv
L2xpbnV4LWYyZnMtZGV2ZWwK
