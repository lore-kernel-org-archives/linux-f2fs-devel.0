Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28619D6CFAB
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 23 Jan 2026 00:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6/qJx/3+ly8uWK47b8pu4K5leB05V2uQot2H1+4Z5NM=; b=MNZ8jfJv118QCbRIyejMRuLeVg
	V6OjAwH+WPufTwmmYE8TDnKWrxVEpqaOuGUl1oB/RqlEzg5ihxLiI4EaXP65i1dnXkEWnAebeJsZW
	XN0CDvu0Di7tWUWWJ8i+0RypCG+9TUpj8OILjv2dUOIiDJKTFCCeEHOM2575PotSHFVY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vj537-0001oy-Sd;
	Fri, 23 Jan 2026 00:29:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1vj536-0001oi-5i
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 23 Jan 2026 00:29:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hmfs4OwILRToImrbCPibfAor8A/SSSSUysNGW1MyCmM=; b=Zihn3GG+0SxNoRqg4d+O+6xN6x
 s8sBpZb5Gr6wdm16q64yHqgvdwky+JrstCrC0qT4DtlKXWqt84bQ621DBa7+1XYE9DZBbBRA+P+kh
 ey7k/PFT6LrRYHz9PoUPf/Jbf/MyrFhCmvc8GW9UKkP8+ziGSOiHnqDHWLeIOq7OYpew=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hmfs4OwILRToImrbCPibfAor8A/SSSSUysNGW1MyCmM=; b=iIKpdvzDbcNEJgqFArZXkZoqz6
 lJG4aDPc3+7sZkxv9plXyDWq73PAIf1yUwABFSU+xB1dvTWJKCN0y/vOjGZj7frd4asioDUNxI4+F
 z7pKaeIydKqvPWjwsD5SZOVNMYOmB4zJRXaohV/NII0dUvoAr0vulg2Xcv/7/VOEzEmM=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vj536-0003tE-GY for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 23 Jan 2026 00:29:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9B1C36001A;
 Fri, 23 Jan 2026 00:29:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47992C116C6;
 Fri, 23 Jan 2026 00:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769128145;
 bh=1HuIvGuXkz2pWV1w44fpAU1mN7kr1kGU7MYcVIW95Aw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Io99X/v41XLeXVi7CpHRRMVsCWA5rsue6cXY+hqoNvs2iQSDT9Ox2cWiFagdlBPlm
 ah+rEm6PNzOZWEIZCiW4qus1HzL6RAmTpJDLKwOMnu+eI6RgqNnRg5FTjTQVQWvtkW
 e9FHwZNjOjZkYYMjeRG3q1yF3Fqk7k2g4548xvsPXwZag81Yw5Yi/1eWnpNmm7/glZ
 a7bMolxu7Abs2p02DnL5Sg+7U3aOjdWDdd/nlvOWypo6z72Szc/ZH7/KcQJ0pABTrw
 w2kJOyP6+0rr4aQAYzNTmp3h3IppLh1+L1YaJJGfdsyQw7sVDAnWzsW8DVW6/uDZFw
 h4baMzKsIr2wA==
Date: Thu, 22 Jan 2026 16:29:04 -0800
To: Chuck Lever <cel@kernel.org>
Message-ID: <20260123002904.GM5945@frogsfrogsfrogs>
References: <20260122160311.1117669-1-cel@kernel.org>
 <20260122160311.1117669-8-cel@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260122160311.1117669-8-cel@kernel.org>
X-Headers-End: 1vj536-0003tE-GY
Subject: Re: [f2fs-dev] [PATCH v7 07/16] ext4: Report case sensitivity in
 fileattr_get
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
From: "Darrick J. Wong via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Jan Kara <jack@suse.cz>, pc@manguebit.org, yuezhang.mo@sony.com,
 cem@kernel.org, almaz.alexandrovich@paragon-software.com,
 adilger.kernel@dilger.ca, linux-cifs@vger.kernel.org, sfrench@samba.org,
 slava@dubeyko.com, linux-ext4@vger.kernel.org, linkinjeon@kernel.org,
 sprasad@microsoft.com, frank.li@vivo.com, linux-nfs@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, ronniesahlberg@gmail.com,
 glaubitz@physik.fu-berlin.de, jaegeuk@kernel.org, hirofumi@mail.parknet.co.jp,
 Christian Brauner <brauner@kernel.org>, tytso@mit.edu,
 linux-api@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, senozhatsky@chromium.org,
 Chuck Lever <chuck.lever@oracle.com>, hansg@kernel.org, anna@kernel.org,
 linux-fsdevel@vger.kernel.org, sj1557.seo@samsung.com, trondmy@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Jan 22, 2026 at 11:03:02AM -0500, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Report ext4's case sensitivity behavior via the FS_XFLAG_CASEFOLD
> flag. ext4 always preserves case at rest.
> 
> Case sensitivity is a per-directory setting in ext4. If the queried
> inode is a casefolded directory, report case-insensitive; otherwise
> report case-sensitive (standard POSIX behavior).
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/ext4/ioctl.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index 7ce0fc40aec2..462da7aadc80 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -996,6 +996,13 @@ int ext4_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
>  	if (ext4_has_feature_project(inode->i_sb))
>  		fa->fsx_projid = from_kprojid(&init_user_ns, ei->i_projid);
>  
> +	/*
> +	 * Case folding is a directory attribute in ext4. Set FS_XFLAG_CASEFOLD
> +	 * for directories with the casefold attribute; all other inodes use
> +	 * standard case-sensitive semantics.
> +	 */
> +	if (IS_CASEFOLDED(inode))
> +		fa->fsx_xflags |= FS_XFLAG_CASEFOLD;

Curious.  Shouldn't the VFS set FS_XFLAG_CASEFOLD if the VFS casefolding
flag is set?

OTOH, there are more filesystems that apparently support casefolding
(given the size of this patchset) than actually set S_CASEFOLD.  I think
I'm ignorant of something here...

--D

>  	return 0;
>  }
>  
> -- 
> 2.52.0
> 
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
