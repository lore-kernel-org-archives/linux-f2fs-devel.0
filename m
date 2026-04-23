Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F3FF99378
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 23 Apr 2026 11:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4ZmDkC6q3eqmQDtDAePo4W6fSL6ByCI0Mpa06vxh9Co=; b=E5hbmuCibK66cftO7rcOi9VTQ3
	fAIM/xtpk2FcBd5wiZeyPGfSjwDER6csxZsNwuK8M0tS4yGf6rvO3/PzLrFOWJehDvH+o8n6llEPL
	L9+NqlKimLsK5TDoRnwxv8IYo8ogW1gV+85aFXibx1lfVYLfTldu2beoR+FPtR70OY8M=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wFsch-0000tg-LE;
	Thu, 23 Apr 2026 11:53:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <brauner@kernel.org>) id 1wFscf-0000tY-O0
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Apr 2026 11:53:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BdIhIybzhhBfcRoUJIsClIcaIKGKryhx1zUe7365G2A=; b=dkaHV5vARlDFyypXlVwIaI3Jog
 XnpvAhotmN9tg0k+xOb2IUfpzdAHh1JpN5i66C5zWQ6JIrYbNURn8UvNjxtSRyI5hJ+tacIjR3UA+
 VCUX/a8asOlNl0hH+7OiRlzacoGP490xLPdveV+4PBMvv0YRMp3cQY3KQbw7aPujh27U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BdIhIybzhhBfcRoUJIsClIcaIKGKryhx1zUe7365G2A=; b=JVECoqGj3YSktFEzyC0t7nodmP
 YRqu41pwzV2Il+Feo6d02TI9oIxdJSecdTGCV7fQFHYAQHKbdudVkPdHPw9NofRn0AVEq0+1p9+od
 Dcx0v+7EhzYl2ga0Fk0ll4R7fSb4HxsejMbO1a+hjX4FzjZfnteYs3k2JrCIs5dvUwrI=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wFscf-000269-6H for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Apr 2026 11:53:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8DA79441E5;
 Thu, 23 Apr 2026 11:53:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20254C2BCB5;
 Thu, 23 Apr 2026 11:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776945202;
 bh=cHE9hrag1OMIex+WXfpjDqBpsMmIUcQJHMPd4Y7yd1s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=R6p905u8w5riLWLBL7tRdD5S09cDEbJnPwWB5RVXAG2eZ8l9DVcz9BdD1snxlZ2Zl
 DQHKLZweSXptmoepemPcv3MQMKXrko/qLSf8d9gekZ9FC9npj1Rl5+g83VEnO+lLev
 xBFP7nCswuXz722eHK8fJ8BLo5Gk/F0+fuLGkDdxYxjQkDltUnC+j+R3mwxhrUbqzi
 NJO+IaFgHoRmOtUENV0fUO142ajvIUPYaRG9OYAFDVcHCovlg6DI0cyER+NKMDRgNh
 vxODO9xb+7N3kQKZvCTki45OQYoSORg/oovwJEvPkMCBEsAvK4tl5B50itIMRurf/p
 QTWH9qc+XS8KQ==
To: Chuck Lever <chuck.lever@oracle.com>
Date: Thu, 23 Apr 2026 13:52:39 +0200
Message-ID: <20260423-notorisch-marmorieren-3b1376711a8f@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422-case-sensitivity-v9-0-be023cc070e2@oracle.com>
References: <20260422-case-sensitivity-v9-0-be023cc070e2@oracle.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3216; i=brauner@kernel.org;
 h=from:subject:message-id; bh=cHE9hrag1OMIex+WXfpjDqBpsMmIUcQJHMPd4Y7yd1s=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS+4pDrrGXLlji/IJ4rYraNoNkSc4YNzkphLnvaDBjuH
 ZDgN+7oKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmIiFB8M/i54I8d9+l7+JLPRe
 ZprEUqdyJzW9MtJsd1YHj5vI9ksXGH6zpfMemLRMIbdowdo3hucvvTqjdGrTptvGfolrD63muVD
 ACAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Headers-End: 1wFscf-000269-6H
Subject: Re: [f2fs-dev] [PATCH v9 00/17] Exposing case folding behavior
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
 slava@dubeyko.com, "Darrick J. Wong" <djwong@kernel.org>,
 linux-ext4@vger.kernel.org, linkinjeon@kernel.org, sprasad@microsoft.com,
 frank.li@vivo.com, linux-nfs@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, ronniesahlberg@gmail.com,
 glaubitz@physik.fu-berlin.de, jaegeuk@kernel.org, hirofumi@mail.parknet.co.jp,
 Christian Brauner <brauner@kernel.org>, tytso@mit.edu,
 linux-api@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, senozhatsky@chromium.org, hansg@kernel.org,
 anna@kernel.org, linux-fsdevel@vger.kernel.org, sj1557.seo@samsung.com,
 trondmy@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, 22 Apr 2026 19:29:54 -0400, Chuck Lever wrote:
> Following on from
> 
> https://lore.kernel.org/linux-nfs/20251021-zypressen-bazillus-545a44af57fd@brauner/T/#m0ba197d75b7921d994cf284f3cef3a62abb11aaa
> 
> I'm attempting to implement enough support in the Linux VFS to
> enable file services like NFSD and ksmbd (and user space
> equivalents) to provide the actual status of case folding support
> in local file systems. The default behavior for local file systems
> not explicitly supported in this series is to reflect the usual
> POSIX behaviors:
> 
> [...]

Applied to the vfs-7.2.casefold branch of the vfs/vfs.git tree.
Patches in the vfs-7.2.casefold branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: master

[01/17] fs: Move file_kattr initialization to callers
        https://git.kernel.org/vfs/vfs/c/a46401c7dc2f
[02/17] fs: Add case sensitivity flags to file_kattr
        https://git.kernel.org/vfs/vfs/c/1dd697879cf2
[03/17] fat: Implement fileattr_get for case sensitivity
        https://git.kernel.org/vfs/vfs/c/2b124bb86cdb
[04/17] exfat: Implement fileattr_get for case sensitivity
        https://git.kernel.org/vfs/vfs/c/9b8b66549c8e
[05/17] ntfs3: Implement fileattr_get for case sensitivity
        https://git.kernel.org/vfs/vfs/c/7d0fbb53b0c2
[06/17] hfs: Implement fileattr_get for case sensitivity
        https://git.kernel.org/vfs/vfs/c/024b4a69abaf
[07/17] hfsplus: Report case sensitivity in fileattr_get
        https://git.kernel.org/vfs/vfs/c/22a319bfe8b8
[08/17] ext4: Report case sensitivity in fileattr_get
        https://git.kernel.org/vfs/vfs/c/75fd84cb0922
[09/17] xfs: Report case sensitivity in fileattr_get
        https://git.kernel.org/vfs/vfs/c/29323822bece
[10/17] cifs: Implement fileattr_get for case sensitivity
        https://git.kernel.org/vfs/vfs/c/4444c82e69a6
[11/17] nfs: Implement fileattr_get for case sensitivity
        https://git.kernel.org/vfs/vfs/c/6f3f50885bd9
[12/17] f2fs: Add case sensitivity reporting to fileattr_get
        https://git.kernel.org/vfs/vfs/c/e8d671306a8f
[13/17] vboxsf: Implement fileattr_get for case sensitivity
        https://git.kernel.org/vfs/vfs/c/f5e334b94179
[14/17] isofs: Implement fileattr_get for case sensitivity
        https://git.kernel.org/vfs/vfs/c/764609f76826
[15/17] nfsd: Report export case-folding via NFSv3 PATHCONF
        https://git.kernel.org/vfs/vfs/c/06726ac88bb5
[16/17] nfsd: Implement NFSv4 FATTR4_CASE_INSENSITIVE and FATTR4_CASE_PRESERVING
        https://git.kernel.org/vfs/vfs/c/d129f0419eb3
[17/17] ksmbd: Report filesystem case sensitivity via FS_ATTRIBUTE_INFORMATION
        https://git.kernel.org/vfs/vfs/c/8179d08606e8


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
