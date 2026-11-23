Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEB2606A321
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 23 Nov 2026 18:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=SDvJqG+v;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=QuSy0kdZ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=RYyhlBZd;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fg1T6wql
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=wwr5f2C0rJOE6XjWODbsdkGZlx4mZpZZXUZFj5Wq46I=; b=SDvJqG+v506r45QEZ11A/0wuFo
	gqO9sp8UZ2jrIdPeZ5K+9pUULp6LbicwLxcFc/wQasP5AAkI3XR/ZtA+G5CEsNhIVfQZkUcV7l/H3
	zPkeZ91Mn7nNiOlc/f914I0ZGC1x37pkOVqF8B1qpGz10OxhqqquTLAvseit95l+8iWU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xVZ37-000000006cQ-19pH;
	Mon, 23 Nov 2026 18:45:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <zlang@kernel.org>) id 1xVZ36-000000006cE-3BR1
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 18:45:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PxiNA7miBJTHGn0Z9SSPAwEi4XJ3UirlOj8JQBSf8JA=; b=QuSy0kdZs9so1bWQ0d5BTRWe1Z
 0x9Ah7TUKyEtZtc2esRL9WjE+8z3qL0vqqnx72EIzQg4NS9+RQVdhSyTAoCJHV1BBlGVOBVd7EXBz
 y12K35FQKZLhas4HO2jnCsuJ/46JFhjHNtkKrxuR3vJwuCiQLXCCuQW6sBsJyzmzCS7k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PxiNA7miBJTHGn0Z9SSPAwEi4XJ3UirlOj8JQBSf8JA=; b=RYyhlBZdI4X0wo1JgonM6v4ZlA
 Ndpb28FZ3YqAYnEau4e3aC6yHEHu8wyHeMRT5apgM5TFYuIyxJJd4/++heng+UOGqhaQk3O1jVA2l
 MC1Tz7m0Cr/kDyHEKffoRZmJZ7Ea9FaRPyGkuSMU0vEFC0W60A0nF0YVckUf5k3M9JsU=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVZ33-000000003tU-3LGO
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 18:45:56 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 617B3448D3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 18:45:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 067081F000D4;
 Mon, 23 Nov 2026 18:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795459547;
 bh=PxiNA7miBJTHGn0Z9SSPAwEi4XJ3UirlOj8JQBSf8JA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=fg1T6wqlWfCdvHfchAwMVIpFqeJYm34dDAF1fdbyHK8/cQtm/QaABqnz9D+g4Sjr2
 SoZrWgXXt85Ls09buOpcM0RhFYgiQm2Yf/8cr6ajo33w9fnurbJW6WyuXHmdA+O32l
 Yu6+FyvJ1P6KN8fKmu4j+GsO58mXTf0xb3l0SM6enPKe7YJu77yXoUKwmo7LP35c0W
 hXq7swXRei4oIZob7BrlQ6x0tY7DTkXF9kRLXY+AdH4Cadecgyj1b7pMFmTgTPspAu
 BmDG4jqJ7GCFdcEY9ZOvgvnCHv+Dc9yrccDDAvSkR8bGSMGpO9B4enYJsIDx1r68Lz
 yYKZfxn/Xe+9w==
Date: Tue, 24 Nov 2026 02:45:34 +0800
To: Anand Jain <asj@kernel.org>
Message-ID: <awSJlKPANuJTZtJK@zlang-mailbox>
Mail-Followup-To: Anand Jain <asj@kernel.org>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net
References: <cover.1791272793.git.asj@kernel.org>
 <d33f55ca2c1b13426dd27c1c9921b2a60c3afbf2.1791272793.git.asj@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d33f55ca2c1b13426dd27c1c9921b2a60c3afbf2.1791272793.git.asj@kernel.org>
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVZ33-000000003tU-3LGO
Subject: Re: [f2fs-dev] [PATCH 10/21] fstests: add helpers to verify the
 expected f_fsid
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

On Tue, Oct 06, 2026 at 04:55:36PM +0800, Anand Jain wrote:
> Add two helpers to common/rc:
> 
> _require_uuid_based_fsid() skips the test unless the filesystem derives
> statfs f_fsid from the UUID alone (currently btrfs and ext4).
> 
> _scratch_expected_fsid() prints the f_fsid expected for a filesystem
> created with the fixed test UUID.
> 
> Signed-off-by: Anand Jain <asj@kernel.org>
> ---

Reviewed-by: Zorro Lang <zlang@kernel.org>

>  common/rc | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 37df780f64ef..a11235ec03b8 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -6065,6 +6065,37 @@ hexdump()
>  	_fail "Use _hexdump(), please!"
>  }
>  
> +# Require a filesystem whose statfs f_fsid is derived from the filesystem
> +# UUID only, so that it is stable across devices and mounts.
> +_require_uuid_based_fsid()
> +{
> +	case $FSTYP in
> +	btrfs|ext4)
> +		;;
> +	*)
> +		_notrun "Require a filesystem that derives f_fsid from the UUID only"
> +		;;
> +	esac
> +}
> +
> +# Print the statfs f_fsid expected for a filesystem created with the test
> +# UUID 12345678-1234-1234-1234-123456789abc.
> +# Must be guarded by _require_uuid_based_fsid.
> +_scratch_expected_fsid()
> +{
> +	case $FSTYP in
> +	ext4)
> +		echo "4c44000088884c44"
> +		;;
> +	btrfs)
> +		echo "444c444c888d"
> +		;;
> +	*)
> +		return 1
> +		;;
> +	esac
> +}
> +
>  # Try to create a file with inode->i_blocks >= (length / blocksize).
>  # There may be some small overhead, e.g. ext2 filesystem allocates a
>  # substantial number of blocks to store block mappings. Those are accounted
> -- 
> 2.43.0
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
