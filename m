Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418E9606A31D
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=AhCY2/KS;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ewwMdKh4;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=j9xrwueW;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VMjfP1hC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=CIe7TFBFXeK5bygiXsNOYYWayHhYOb1Miyz9K3o9E0w=; b=AhCY2/KS6ZGwus
	R85p7kJzGuLunh1Fz/bufA8Eq3F+2UYN79TuC5cxSpf9miaNvG10LZuMUdmGc7gS9HSfYyCZXYLeG
	W6Tm00nqzKjFNelGah7MpRTDEFWD9ErtBe7cv8rVC6q1t75+ZnuCUXsToO7U22XXa7ND3oe3K47xo
	t5M=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xJsi5-000000008GB-3yYf;
	Thu, 22 Oct 2026 13:19:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <asj@kernel.org>) id 1xJsi4-000000008G5-3rPk
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 13:19:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7kt/YewBZ5WO0DwXwreE4/5FyPrbACcihIhoifPaG+M=; b=ewwMdKh45fDCMTc7XoLa4rFP9e
 ZjAKDrVlxdTbGikYFKWnLbnIXRKzSU+t0UclfnQ6kAOKI7sjQTS5hXqELHqYcgbe3iC1NTq0Jm08w
 dDTQ8F5n13taTUQZ5jEpeUVA0QaR0oq+MHQKF273lyIulW0MFkiUpJvE/cjxWlpI5ym8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:From:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7kt/YewBZ5WO0DwXwreE4/5FyPrbACcihIhoifPaG+M=; b=j9xrwueWKuAe1tBOjsYPrMi0w2
 LKoOvQnwfxh7c7uFY0KDlUQCs0yc3+x0hlQN1DqBeK70fa3mqqAOgSLriNeNk/M1TKaRQIGfPsqsn
 0r623YXXk+T2MkuY02ppWIOk3odGT4Qj/LrM21Mo6Y2rdjIi1qhtNW4SU0x2ylFqq8nY=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xJsi3-000000002Cy-1Re2
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 13:19:56 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9F055601F1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 22 Oct 2026 13:19:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E21AF1F000C1;
 Thu, 22 Oct 2026 13:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792675189;
 bh=7kt/YewBZ5WO0DwXwreE4/5FyPrbACcihIhoifPaG+M=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To;
 b=VMjfP1hC/3168FSqouAqzgo4s6o2H+anHy/f5E41DfZIhB2p5aRXQAawycCSmj8YX
 QULhEsj5UAwYWC9FL5tJWpBdKd8ib2UuXamnEalDNILnfu6REb8Az4CbLtMKIJdHbO
 1ZdG3TJBUW+2A8H9MA9oTw+gJr0u1sjU64g1QelEm01PKnkQyRQlCD2343xtsDxTHY
 wDOnXYsmTPVAtMIeAuJ4RTnlpwpdiZbZcMFKsBERyXb8SpTxdezvj2sKjWCMl49hCl
 49jltMEPmIP7aheElfY511NoBX4Hp8cqZvnhh/gUdH+/I2A9ZWhJbNBWvN73AHshYU
 2ocXd8Tt/+SNA==
Message-ID: <0ba3f0a0-7e8e-46fc-bcf2-29935e8400d4@kernel.org>
Date: Thu, 22 Oct 2026 21:19:46 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: zlang@kernel.org
References: <cover.1791272793.git.asj@kernel.org>
Content-Language: en-US
In-Reply-To: <cover.1791272793.git.asj@kernel.org>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xJsi3-000000002Cy-1Re2
Subject: Re: [f2fs-dev] [PATCH 0/21] fstests: tests for cloned filesystem
 validation and f_fsid
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Anand Jain via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Anand Jain <asj@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ping?

Regards, Anand


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
