Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (unknown [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42BC7C6FD1D
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 23 Mar 2023 14:47:19 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pfMDm-0001P1-9c;
	Thu, 23 Mar 2023 14:47:18 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <tytso@mit.edu>) id 1pfMDk-0001Og-TO
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Mar 2023 14:47:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8/XjPODeu0U61LLY1URpwJZq2KMUV1l5jOCz8NiMPdQ=; b=MeFBdMedxAqEstFGRUgYemJ6H+
 t74zgHMHWOTmn3e6pmSvPikX8lZtbap1wB6l1XZpyw0BPEeXIIkGK1eLugCgIPcLReFUknj21TcN8
 h1gcAcASdmk1m0f/ihebWaB8+JXCRtQOw4FwEuFJHVjh9YyBWPqKTXOSwPD3Nx4ajmZU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8/XjPODeu0U61LLY1URpwJZq2KMUV1l5jOCz8NiMPdQ=; b=b6FpLSefsGwKZt1KhYb9n8iwcF
 9zJ1VoidQXq7dsZhPADWM8r14hhncY/fHPBnI6yLZW4qk7IdQYm+2gyW7yi8lPKXuwjZZN8hwoAdL
 wdbI7gzsJ8e4KsSMTbZAe93IM2BtBnOSKVjsPQcAZAhzx/RmIiL/r6EIJ9HMpc5UCkU4=;
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pfMDk-000J6U-Hu for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Mar 2023 14:47:17 +0000
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net
 [173.48.120.46]) (authenticated bits=0)
 (User authenticated as tytso@ATHENA.MIT.EDU)
 by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32NEdIe5013698
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Mar 2023 10:39:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
 t=1679582360; bh=8/XjPODeu0U61LLY1URpwJZq2KMUV1l5jOCz8NiMPdQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ep1ZQ3GezGLfxjhBlLVfubph32pGgPm4APh3vEDMfPUjyviIgN0CDMkorz3X8p8a4
 PRR5/QYpLJNF6E3egsTSavfQxkCWXrMoerQMTfGbse+5Tw4olHwVG82LELtw2HMaPu
 DXeEeDcsfQwGtKnJBooJWemH6YGX+ur7Yj6t3PMdwfbrPUTEA8AJENb46JNJAMuCPY
 3j/t7FTGcaAHGMH1LsLqMaokonhhO2+Jgu9hVmWeAYuY/AjOUVQuNHsQmT40FZPnVC
 oyxAd3VCISLLH/kb3wTWfVxrrAs3m4FwkLyawaubJPbUO7M3d/jyjO/epS0fGOIhsm
 Itx+LwmcH58Vg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
 id 7A75115C4279; Thu, 23 Mar 2023 10:39:18 -0400 (EDT)
Date: Thu, 23 Mar 2023 10:39:18 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Gabriel Krisman Bertazi <krisman@collabora.com>
Message-ID: <20230323143918.GG136146@mit.edu>
References: <20220622194603.102655-1-krisman@collabora.com>
 <20220622194603.102655-6-krisman@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220622194603.102655-6-krisman@collabora.com>
X-Headers-End: 1pfMDk-000J6U-Hu
Subject: Re: [f2fs-dev] [PATCH 5/7] libfs: Merge encrypted_ci_dentry_ops and
 ci_dentry_ops
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
Cc: kernel@collabora.com, linux-f2fs-devel@lists.sourceforge.net,
 ebiggers@kernel.org, viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
 jaegeuk@kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Jun 22, 2022 at 03:46:01PM -0400, Gabriel Krisman Bertazi wrote:
> Now that casefold needs d_revalidate and calls fscrypt_d_revalidate
> itself, generic_encrypt_ci_dentry_ops and generic_ci_dentry_ops are now
> equivalent.  Merge them together and simplify the setup code.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Reviewed-by: Theodore Ts'o <tytso@mit.edu>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
