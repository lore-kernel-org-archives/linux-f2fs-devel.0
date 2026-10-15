Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E1E6CA9EDE
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 15 Oct 2026 03:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:Message-ID:MIME-Version:References:In-Reply-To:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y+dmx/eb1iDp5gCSZyp22/sBLlJV+Iii/Td3jD5cvZA=; b=Bz7lQNdxe9r95cenBS+EGP9g7C
	ymW9LcDiF0/qst7G36BFyYJgw2W/ELTl+wSginUGO6wo6xqewWy/ZbeNWMRs0UgMp7Av3LE3wZh23
	KN7souu0HIzQohx2FZzeFsmZesQWmLSvpBVEDT2O3fRd3pDM2dkk2jtayXnMhdqOBZpE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xHCEI-0008VN-8X;
	Thu, 15 Oct 2026 03:34:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1xHCEF-0008Ur-TA
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 03:34:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:References:In-Reply-To:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MnGQMt0B+jafHRN1v9xwEh/qdzGR5vav6qA43leZFgE=; b=m7p9l/loCFsK1GWgNt3FEzWDHU
 4susTx8p7mL+ocDzIPcBYWeu5MtUB7AodPkaYlj1ksJwINHBJSwC2mRIz7gy10zUa3XrwBNIc1Mur
 lNaTj2CRhaql8uMa4tgGOif3jc+HQDUblSx/mJ/PwMsZqdu05+0V6gJX1Qot25J0uegU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References
 :In-Reply-To:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=MnGQMt0B+jafHRN1v9xwEh/qdzGR5vav6qA43leZFgE=; b=cC2NAKVvoz/pz/m9U1SGOcsrUQ
 fVgxTaXOYJDDvmrxBaiEe/gfqYBs1tVHhyJ2ZtjrCWvgVjldNqoUTpBzYLFwKh8oJW0biH75uikw6
 nc2WJMxcZMoBsPJMe3qqt8g4PHY3ybzT4iBcMjpcmRdeNWwToIVytDR+hX30NWhklcuw=;
Received: from m16.mail.126.com ([117.135.210.8])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xHCEC-0003wR-Hz for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 03:34:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
 Message-ID; bh=MnGQMt0B+jafHRN1v9xwEh/qdzGR5vav6qA43leZFgE=; b=F
 pWO/qtRU4qdwejGJjnYOX4mISr+TjgR4MJRJKPD/7sqN1JiMsK8zG9TI22j+yjL1
 mo//afTiP/oaKMziGvHFUo+yGwW2fcG9myr+0cKL4tS7DOeaMuyixCg6ZSyrDOZW
 XvmeXf8k/93TohFlzW4/yn9qv/4I0NYflymmPPIv/c=
Date: Thu, 15 Oct 2026 11:33:26 +0800 (CST)
From: "Nanzhe Zhao" <nzzhao@126.com>
To: "Jaegeuk Kim" <jaegeuk@kernel.org>
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 126com
In-Reply-To: <atA24UMtAqkmz_R8@google.com>
References: <20261014064445.2835813-1-zhaonanzhe@xiaomi.com>
 <atAO6ykqwGgZq77y@google.com> <atA24UMtAqkmz_R8@google.com>
X-NTES-SC: AL_Qu2SAPyYukor4CKQZ+kdmEoVj+o8Xsaxs/8g2YJSc80Ooxvs5zIGU2d5Anvw/ei9Fi6BrjG2fgRi+th/Y6NKmr0loRDCOejQg3W8Nc3mDA==
MIME-Version: 1.0
Message-ID: <63e416aa.2fb2.1a13d9f3491.Coremail.nzzhao@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cykvCgDXf2aGSdBqhNdPAA--.26047W
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBogZCEmrQSYa7wQAA37
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Headers-End: 1xHCEC-0003wR-Hz
Subject: Re: [f2fs-dev] [PATCH v5 00/16] f2fs: support & optimize large
 folios for writable files
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
Cc: Nanzhe Zhao <nzzhao.sigma@gmail.com>, Barry Song <baohua@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, Juan Yescas <jyescas@google.com>,
 Daeho Jeong <daehojeong@google.com>, Pengfei Li <lipengfei28@xiaomi.com>,
 Dev Jain <Dev.Jain@arm.com>, linux-kernel@vger.kernel.org,
 David Hildenbrand <David.Hildenbrand@arm.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Ryan Roberts <Ryan.Roberts@arm.com>,
 Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net


Hi Jaeguk:

>Ok, this comes when applying "f2fs: carry subpage offset and count in write IO".
>

So we didn't reproduce this bug with the whole series patched on dev-test?

Thanks,

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
