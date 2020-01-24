Return-Path: <SRS0=bY38=3N=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5C1C2D0CE
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 24 Jan 2020 04:16:39 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDA6220708;
	Fri, 24 Jan 2020 04:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="J+90cD1T";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="HskRN9BT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHP+pS+N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDA6220708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iuqOc-0004mK-Qo; Fri, 24 Jan 2020 04:16:38 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1iuqOb-0004mB-4O
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 24 Jan 2020 04:16:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fgUC/4yLXQ28EPDR9YBF9XRXJ4YzOA8FvXiUDBnDG+A=; b=J+90cD1T4r8OmEyaEgTqLAcG9p
 zsS6zzX/hLn/my5285TZBdhJ0YeUE07Nsy6E756mMoNi6oupz9fUg7KwwvbyjTMo4zoQSEYamUOLZ
 mbyo/6T74JImPBG/ZgbHXpuhnWkp8f1eDQPDo/bDGR1jV8iz3pN5ovjGLgvRDPaA53Zg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=fgUC/4yLXQ28EPDR9YBF9XRXJ4YzOA8FvXiUDBnDG+A=; b=H
 skRN9BTs5adghs7l+PK5Lpt/9f4lZQ0qoeblJszSs5K5aa9UqH5iBS3KcNn+dsWbhQ83vPY1ZXudZ
 AT7KhJqP5Sa9liX9Ya4eoeK2RoVqR8P6XMHCaeJL+JQYThjrZ40biQM5CFJLf2kBOY729zNq7S33r
 U33c3sjdj5uvZHnw=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1iuqOW-003EYX-Mq
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 24 Jan 2020 04:16:37 +0000
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net
 [107.3.166.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D921620708;
 Fri, 24 Jan 2020 04:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1579839387;
 bh=EuvhQIPwiMkjWMW2ISI1mewp2CJ8ykDJLYX5MlF0CcQ=;
 h=From:To:Cc:Subject:Date:From;
 b=eHP+pS+NYDGAIxKniN2dbZQLhV5h2aQqWDa5h43MbjEDunKHq2LKx0at1fs1MIFlN
 0d8O3rmwM54wrTjSxdwZE5wLfZDrnfnrHDECzeBF4MXFfO8fBUoMmaoVR2xsyw5iwg
 cZivPEaFmaNZp1k470qU0S5EE09fFOcpBvpMGNug=
From: Eric Biggers <ebiggers@kernel.org>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Thu, 23 Jan 2020 20:15:47 -0800
Message-Id: <20200124041549.159983-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
X-Headers-End: 1iuqOW-003EYX-Mq
Subject: [f2fs-dev] [PATCH 0/2] f2fs: fixes for f2fs_d_compare() and
 f2fs_d_hash()
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
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 Gabriel Krisman Bertazi <krisman@collabora.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This series fixes dentry comparisons and hashing on f2fs filesystems
with the encoding feature enabled.

Eric Biggers (2):
  f2fs: fix dcache lookup of !casefolded directories
  f2fs: fix race conditions in ->d_compare() and ->d_hash()

 fs/f2fs/dir.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

-- 
2.25.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
