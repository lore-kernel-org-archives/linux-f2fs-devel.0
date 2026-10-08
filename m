Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B61CA600D
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  8 Oct 2026 05:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q49MOoHl8eB0Vq+FBNVDSFy0ledRIcqlT8a19lxD/4Y=; b=SEZix8SyRKE7qUBT7LSOKOiap1
	2zsTDfqHw4GgPNcQ4g/6Wzyfv9qu05fkqFenus1bouPwOrRevLh+C9+951zH7vbGSTzU9f9PshXp6
	sGFs0GilEWBvuZukCE4+IgN08pAmUdSZmcBcK7Z8Va2JBuXkwewSCraDQPyEvyrhlb0U=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xEglM-0001Rq-R9;
	Thu, 08 Oct 2026 05:33:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1xEglK-0001Rk-NA
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 05:33:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CARflcBGpvRN9r7V0tWqypeX79CxYIU+874ZDeCSN/0=; b=P2MQSu++UYZRzqAyTrpPQ8OfTk
 w+O7wJsGrvmyyy7+xbOt7sQIbtio/mk8kEVXl60BDm17e2eSowKiM87fsoJJFaVyly11cYLzDYARP
 elk33QOsz750fCLsdcztYR/WKN5VUTF+rn7wv9rJZLH922ui9AT8d/M43FjpDm1mBDIk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=CARflcBGpvRN9r7V0tWqypeX79CxYIU+874ZDeCSN/0=; b=DS941mPgaqP5wbYk6VSLHmAXYY
 yCZwoFTXCzoYUgW6429RKcQ0Q3sTQlIhI1kXEdBLQYGUvZkQmHhtsWp3PRqMKLGd/a95vozw5RRQf
 /rAdiDTxQkIzolxEz2T1htbRdLKsHrQBLfwApbw+DtW5bCj9rp3D1+mrG0lVS4scFUYA=;
Received: from m16.mail.126.com ([117.135.210.9])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xEglI-0005fk-GF for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 05:33:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=CA
 RflcBGpvRN9r7V0tWqypeX79CxYIU+874ZDeCSN/0=; b=Jf3EmRSfIltCfdFpQL
 j1M/RuLOlIuVPmipLei5NpwfAqq2v9yscMNET26fb0pn6SHTybIvEcx1X0TF57VJ
 A/63GUquJXR7eJjBnhzckLCTS6GJfK3+ldCCMTZnQrthPlpThQEx7pYV8XTwjC4o
 kSiGWz5x50uQ5JSsz3PTaqIuc=
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn (unknown [])
 by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id
 _____wD336sXK8dqurzWAg--.64007S2; 
 Thu, 08 Oct 2026 13:33:12 +0800 (CST)
To: Daeho Jeong <daeho43@gmail.com>
Date: Thu,  8 Oct 2026 13:33:11 +0800
Message-ID: <20261008053311.712223-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CACOAw_zwgUPLkU5BJGE3p2fXecEncPYwRAq0hOB71oks0JUpPQ@mail.gmail.com>
References: <20260915041909.2903887-1-zhaonanzhe@xiaomi.com>
 <20260915041909.2903887-4-zhaonanzhe@xiaomi.com>
 <CACOAw_zwgUPLkU5BJGE3p2fXecEncPYwRAq0hOB71oks0JUpPQ@mail.gmail.com>
MIME-Version: 1.0
X-CM-TRANSID: _____wD336sXK8dqurzWAg--.64007S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4REWlvDUUUU
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBsRldLWrHKxm8tAAA3P
X-Headers-End: 1xEglI-0005fk-GF
Subject: Re: [f2fs-dev] [PATCH v2 03/14] f2fs: support regular file buffered
 writes on large folios
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
 Dev Jain <Dev.Jain@arm.com>, linux-kernel@vger.kernel.org,
 David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Daeho,

Thanks for the change.  I would like to integrate it into v3, folding it
into the "f2fs: support regular file buffered writes on large folios"
commit.

My patch adjusts the signature of 'prepare_atomic_write_begin()': for large
folio compatibility, the 'unsigned int len' parameter is replaced by 'pgoff_t index',
so that the helper can be called in a loop from 'prepare_large_folio_atomic_write_begin()'. 
I found that len was a dead parameter in the original 'prepare_atomic_write_begin()', 
so in v3 I will not pass blen to 'prepare_atomic_write_begin()'.

Thanks,
Nanzhe



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
