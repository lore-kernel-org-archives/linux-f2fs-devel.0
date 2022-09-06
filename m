Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 060F5C38145
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  6 Sep 2022 22:09:06 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oVgki-0004ci-0l;
	Tue, 06 Sep 2022 22:09:04 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1oVgkh-0004cc-ES
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Sep 2022 22:09:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3TBOFo7jiYguN3wpoMqqZVHNPKTtOvZRQEa4uhgrorU=; b=FRM6rA4wfsYvGf+hplZ2fpeqDa
 0mI/Vrucjab1lAkSTY5jzBr7dQpvXJxSlqRb3aMAuUj91UG2TH4NqlOq7dm9PavF6esZoAm/hRyNN
 o5kdOVfpbvmZWYTeryefT8o5eo80k6ARTtZnWEGt+zIk132jNSavHS51LfT0PCUnCgxg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3TBOFo7jiYguN3wpoMqqZVHNPKTtOvZRQEa4uhgrorU=; b=fBDOlnm2YJZvJj87BfNU+E7cHK
 j2HJ5QPs6fL+C7QMuH/X1ePEibvpKLz9JNZs/TVOlQ/4ewQyjCL+SZYUEtsiGXCTwQfo/Tgfx5buZ
 qYjCkxj1PK1N7mmZT6p6KgiqdEZg9GF374PyeozLIpnIjhMguQfx7LLt42YkG6BhPyMc=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oVgkg-000DsB-Pn for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Sep 2022 22:09:03 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 320A7616F9;
 Tue,  6 Sep 2022 22:08:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433FFC433C1;
 Tue,  6 Sep 2022 22:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1662502133;
 bh=uyaghLFUj0ZUpYv1BfsnZYUsPz1vG7taUX0PRzOUbWM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=V38ZoxcxLYyfWiUeHT6Fl+831Rgi6pJi6COWb6dgkYbZBhuGgqt1X+ndhxdRu8NcH
 PhQMZPmU2h0D39SdC2RSKkt1HyFT8NdUl89oV6Ixn9pI17mj7ER4d2Hc9huXWeCbNq
 i+3i8uYL5SnvLWF9WFqcnE99gSR2YmtDv75VhV5qGNsNOxhiapoN8pvJ9ncdsdAIX4
 bvVdcog5eFVzlkDnJf3hJMHUE9BSTikEfHZbG5nhBuv+yjnoIy7446EGgl9bQEN5w4
 6CQIL+JCmEpSFleBZP0kvFhoiQ63H/GuEzJnaKlanPcBDK9nzEN0FReaF0ufHZbnRW
 3HmhWtJtQr0HQ==
Date: Tue, 6 Sep 2022 15:08:51 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>
Message-ID: <YxfE8zjqkT6Zn+Vn@quark>
References: <20220827065851.135710-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220827065851.135710-1-ebiggers@kernel.org>
X-Headers-End: 1oVgkg-000DsB-Pn
Subject: Re: [f2fs-dev] [PATCH v5 0/8] make statx() return DIO alignment
 information
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
Cc: linux-block@vger.kernel.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Aug 26, 2022 at 11:58:43PM -0700, Eric Biggers wrote:
> This patchset makes the statx() system call return direct I/O (DIO)
> alignment information.  This allows userspace to easily determine
> whether a file supports DIO, and if so with what alignment restrictions.

Al, any thoughts on this patchset, and do you plan to apply it for 6.1?  Ideally
this would go through the VFS tree.  If not, I suppose I'll need to have it
added to linux-next and send the pull request myself.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
