Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC8F0D72379
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 23 Jan 2026 12:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZSDoOF0uKv4wMbrdjdzgB8A71eQzJCSFlU5Qsdk6OnU=; b=QYaKSln9ZGseKSPGpA9uYMwieA
	f5WadyyNo1N/SRpbq+E4ziaqA89w+XaiYQff13hcA3mlYhHg21+aR4wzS/Tvto8idsIoZ6Yx+IEWu
	bTPJUssS/4Yze0xl6wElj89yV57IWRAJhj+iWNrij2sstKGtKxEuw7zFmeltQQYfUW7Y=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vjG1s-0003Nf-Gk;
	Fri, 23 Jan 2026 12:12:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <brauner@kernel.org>) id 1vjG1r-0003NT-SP
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 23 Jan 2026 12:12:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2PkYR9UHdcM082D5EGL+eh8dNzXnIjYg4vaNcq5QCmc=; b=eDOoQyyeigzZHdegH8KlKivJ0h
 Ssqk+M3qO7mYTazlLVM6Wk8dJiDntEb0jszA1y3tX8Nji9646y37EbAFbEMHwsn9EzMehUAE1TbL2
 5VPGHvzBqHmxuIvY6y3ts7I5dEDRzp2GT98+z5SuvbaUFoUaLuMLYkrVEeCtFA5iczkQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2PkYR9UHdcM082D5EGL+eh8dNzXnIjYg4vaNcq5QCmc=; b=ZhF1agUkQ2bifufcoE/M3xOYvv
 kbmPDj0brnN3z3JE4QVUtZyoEMbEFM52wFikJCoSeiXYSuU6+k1yka+CBP56bD8cy1s5Cm4tI0pD+
 8dSbfqyhSAQ1fP3JFYje4fV+BaeD/45srAo7Bo5f2bIbDbpj/YGpqnIBDypBsxVriNFk=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vjG1s-0001Xy-An for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 23 Jan 2026 12:12:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id CF42B419D9;
 Fri, 23 Jan 2026 12:12:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 173F8C19422;
 Fri, 23 Jan 2026 12:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769170353;
 bh=2PkYR9UHdcM082D5EGL+eh8dNzXnIjYg4vaNcq5QCmc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qTHL4Poufr50hv0ZoquiVLbCF40danNymQHUU56GSwl2XLv+LALmZ/HXYvFpocKv4
 k1h4Wlp9MnueK54p2CHrnc64EepZsrZ6nq5UI4NyQitG4zl8UJTbvfZxZqNs8nnH+l
 8KDuh+ARtJZcGD4F+rC2sZN9yXrf5B99Da0A+JDeYSgC09c0A6zoLDC8rr2CrtA1qn
 lwrLypBFq9b02SFhuBoWdQioaLqdVDKNzienquQWNEEXkX+8zBNoa7YfiZzgx7qUR5
 Ktyf5wFqAMNda4SN5LdIy/sjiYeJ3if0pbo4cjELzzF6sow0yQjN6buJ3ckypJ9FZt
 JqMMdi+HBlLjg==
Date: Fri, 23 Jan 2026 13:12:24 +0100
To: Chuck Lever <cel@kernel.org>
Message-ID: <20260123-zwirn-verfassen-c93175b7a1ee@brauner>
References: <20260120142439.1821554-1-cel@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260120142439.1821554-1-cel@kernel.org>
X-Headers-End: 1vjG1s-0001Xy-An
Subject: Re: [f2fs-dev] [PATCH v6 00/16] Exposing case folding behavior
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
From: Christian Brauner via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, pc@manguebit.org, yuezhang.mo@sony.com,
 cem@kernel.org, almaz.alexandrovich@paragon-software.com,
 adilger.kernel@dilger.ca, linux-cifs@vger.kernel.org, sfrench@samba.org,
 slava@dubeyko.com, linux-ext4@vger.kernel.org, linkinjeon@kernel.org,
 sprasad@microsoft.com, frank.li@vivo.com, Al Viro <viro@zeniv.linux.org.uk>,
 ronniesahlberg@gmail.com, glaubitz@physik.fu-berlin.de, jaegeuk@kernel.org,
 hirofumi@mail.parknet.co.jp, linux-nfs@vger.kernel.org, tytso@mit.edu,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 senozhatsky@chromium.org, Chuck Lever <chuck.lever@oracle.com>,
 hansg@kernel.org, anna@kernel.org, linux-fsdevel@vger.kernel.org,
 sj1557.seo@samsung.com, trondmy@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

> Series based on v6.19-rc5.

We're starting to cut it close even with the announced -rc8.
So my current preference would be to wait for the 7.1 merge window.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
