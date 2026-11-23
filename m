Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA077606A31F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 23 Nov 2026 18:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=BrXglE8n;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=HAFkGrE3;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=RzQHvNEW;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bGeVa/yA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=9hobbd1cY+UpSmK88/DdCdaFwdCVna84TDpCDRL0WhA=; b=BrXglE8nxaNA0MaUxWW77bynpn
	wXhLDU2bNPvedMlj9v5myye051xnt5zOcWxjBiEbftxZ63JaTaLo3vEapeb/zWl1BPPNLtzqQdW4S
	9ZRC/ktLU0nFZX2x2QfIElFtSqPhbynaq3nABLLgyMdNm2XShDRczraUFQ4jmzs55sXM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xVZFE-000000002Re-2TfH;
	Mon, 23 Nov 2026 18:58:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <zlang@kernel.org>) id 1xVZFC-000000002RW-2dxB
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 18:58:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UCWAc74X2Sila0MeqKGLJ6slVwlYxSmjvDKNYU79/Ys=; b=HAFkGrE3VvOzSrTIwud1a+mn8M
 l/+LPfo2e12rydZQ+m419GARFT50br2CvnclTOGWesQmqBWqj2BTX6M+5ZTJRptqRADwFEv/IH2zv
 SXzqEuKA2QiMjk2XMEgJ0qG4emlzcVRqbI6+YNLtO5EQ51t3mSKjaG3Gdz4upaMzaX0Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UCWAc74X2Sila0MeqKGLJ6slVwlYxSmjvDKNYU79/Ys=; b=RzQHvNEWXZCCsQDgCuXLFr1dWw
 uD9Rln+plpvLbomqoQcYHU7xCWslXkB0sH2Xe+N8Nar+rHyH0yH2NGxVYs8qqCMPREL3FfZ3fiTYP
 O16LWUy+txVkQbTpucn+fsTgNJ1uvfk6ekAa7eG+k+/4W4bYIqcVwmjqGwJ21ujVgg8Y=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVZFC-000000004CA-0uSg
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 18:58:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E0277450C0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 18:58:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32CA61F000C0;
 Mon, 23 Nov 2026 18:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795460300;
 bh=UCWAc74X2Sila0MeqKGLJ6slVwlYxSmjvDKNYU79/Ys=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=bGeVa/yAZZ4BgUJl1s+v6B1kSZtstNuWk/KD/ClOL+f1n9/Vk7ykUhxwqGqJnHLdw
 TZNz+k4Zcpt5eoA5grLrXxYL50NVS18VhYJEP0zbMmDtgo1GE0CGkTJl+Adrsp7o2U
 jNPiFHgxsAofoQmee2lnc7AO8RJjzEi+pOu1NvTs9Cq8JoP3mtxC0SyyPFRtFz6UGR
 MWxeJcO4HDlrZ1QhBMLFVKPXVrK4aJIcoAADOBBWly+R9vqtAS9M3UynloeJuzbPGB
 /m1X2iUGFnzHxozKIxjSRBQdmg5EvBYirlu/JEXrGoocs4L4N2r05R+0l0+ERUU8y2
 KxV/oeQNVMPbA==
Date: Tue, 24 Nov 2026 02:58:11 +0800
To: Anand Jain <asj@kernel.org>
Message-ID: <awSMoVcHT6CvbXdw@zlang-mailbox>
Mail-Followup-To: Anand Jain <asj@kernel.org>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net
References: <cover.1791272793.git.asj@kernel.org>
 <2d4f4228bd376e234425fd2b23692820593486a4.1791272793.git.asj@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2d4f4228bd376e234425fd2b23692820593486a4.1791272793.git.asj@kernel.org>
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVZFC-000000004CA-0uSg
Subject: Re: [f2fs-dev] [PATCH 16/21] fstests: introduce
 _require_metadata_uuid() helper
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Zorro Lang via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Zorro Lang <zlang@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 06, 2026 at 04:55:42PM +0800, Anand Jain wrote:
> Add _require_metadata_uuid() to common/rc to check for the required
> userspace tools (xfs_admin and btrfstune) on XFS and Btrfs, and verify
> kernel metadata_uuid feature support on Btrfs before testing filesystem
> UUID changes.
> 
> Signed-off-by: Anand Jain <asj@kernel.org>
> ---

Reviewed-by: Zorro Lang <zlang@kernel.org>

>  common/rc | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 4ae3c74a52cf..bc0522dbcdd3 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -6527,6 +6527,24 @@ _require_unique_f_fsid()
>  	esac
>  }
>  
> +_require_metadata_uuid()
> +{
> +	case $FSTYP in
> +	xfs)
> +		# The xfs_admin utility is required to modify the filesystem UUID.
> +		# Kernel support for metadata_uuid has been present since 4.16, so
> +		# it is assumed to be available.
> +		_require_command "$XFS_ADMIN_PROG" "xfs_admin"
> +		;;
> +	btrfs)
> +		_require_btrfs_fs_feature "metadata_uuid"
> +		_require_command "$BTRFS_TUNE_PROG" "btrfstune"
> +		;;
> +	*)
> +		_notrun "Require filesystem with metadata_uuid feature"
> +		;;
> +	esac
> +}
>  
>  # Computes a percentage of the available space in a filesystem and
>  # returns that quantity in MB. The percentage must not contain a percent
> -- 
> 2.43.0
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
