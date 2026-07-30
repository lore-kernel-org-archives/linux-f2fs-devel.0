Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01119C54FD2
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 30 Jul 2026 02:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vz7w2q3gWdDN3jrJsW7j+Al/GAMUE+4aXklPCtMTolU=; b=ld8iHS5rk3ZlQii0WVc1PslsGF
	GLL2iA603HzFd/GJmVeyWXXYiaM+sKbiFxyNUn1ooyesU9zx6k4Dt++V1Wx7WgfUG67R+Qrb2V23M
	lv6NcwyGVkMenp6GGYHR0bILR3jTp3Bc+J6sz9YC0piiaum/nkK4/xE29f9uGBL8+oQg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wpGhi-0002ss-Pd;
	Thu, 30 Jul 2026 02:41:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sashal@kernel.org>) id 1wpGhe-0002sc-Ss
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 02:40:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3EqODoI/vfXaEcbRz5tjhLuRmz5P6DhFL1Bj4v+bvGo=; b=DCjeCYWfbn8G8YN2ezf9yXkXCK
 t3mTFaqj57fmv8kEYBQ5UN6NbGgJKGM4cpkwp7eLtBu/2BPagr0Ybb4Ra+jJUpHgLD8E6OVHqXzNR
 7JWZKmmAWccQ0QBWCPXeKbHuXKY8jBS+XCWQ68omvJPwbJbmOtCLaRlumTidO4qQnht8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3EqODoI/vfXaEcbRz5tjhLuRmz5P6DhFL1Bj4v+bvGo=; b=a63ScwEjc8dIsYbkSbQHkOe+eo
 g2qsTljbg+eCfg24cfWzJkNgQfg59erWYybOWan/zmiXjjGE4Hs0N0ulECRsV0xnObyEVxRns5h90
 vXoHc69nQkl8kzkcDuDRMiE5kRWrfsiPw4NxfkzOtlS8ACCK7KgYuk8ikSXNGyEdCYLg=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wpGhh-0008M2-Gz for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 02:40:59 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 62EC642ABA;
 Thu, 30 Jul 2026 02:40:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98C9B1F00A3A;
 Thu, 30 Jul 2026 02:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785379251;
 bh=3EqODoI/vfXaEcbRz5tjhLuRmz5P6DhFL1Bj4v+bvGo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=M9+xhoiSMYHo/OBtz3AZqVOlhu/gJJPXi7IauLNkPhDEZQlhVfEHMZs0WBq/g3QPA
 dwDXaXTK2kPd1Z/MrEkSCIu0MxIL91GkZXFjSIlLsv4q0x8lU2lUsgGzgBZefhSAqt
 pMbf+CyvkHjuvc+ykkRYeyBltTxXrPpa3eNJ9GeQjpaIWRpsZbJCdlq/zbJ54hEUz5
 GqsBzQVPHp5YW1sqszCEVMtXTWwvJW0Kk/+HUupYNYOqXcACy+h9JVaU96qMp18UOf
 pYhmklGXkRBLcSEcUuv6nu/wXHrNvln1q+EO15DAKhYDjC0WCTWTlxMQRGgORWdJ0u
 3fBbsYTRBliKQ==
To: stable@vger.kernel.org
Date: Wed, 29 Jul 2026 22:40:17 -0400
Message-ID: <20260729223316.stable-0021@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729152655.28111-1-ebiggers@kernel.org>
References: <20260729152655.28111-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wpGhh-0008M2-Gz
Subject: Re: [f2fs-dev] [PATCH 6.1] fscrypt: Avoid dynamic allocation in
 fscrypt_get_devices()
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
From: Sasha Levin via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Sasha Levin <sashal@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
 linux-fscrypt@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

> [PATCH 6.1] fscrypt: Avoid dynamic allocation in fscrypt_get_devices()

Queued for 6.1, thanks.

-- 
Thanks,
Sasha


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
