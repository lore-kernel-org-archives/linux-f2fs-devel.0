Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8170606A31A
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 23 Nov 2026 19:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=gXYpN0mH;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=gK9GNs5t;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=RLiEFO1u;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b0C6ksNJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=HV6F04ZZgsn+NShQjmsEtoxuYxYVN3QDEtUCv8gMgoM=; b=gXYpN0mHvQzh7WYOc/AAl8vJYg
	L36JCLBM6aMFhra+m3MbZC3B/iKmp0PGBa6lLQVUIV8ueXBdFlDRogR63xYotFpw6pZs68+mr4Imp
	/kXsDy40N4cma0g0+yZIdIv5lHYtH8kPhv4dBXwMubuOvSeNRZmMNG/CQjLjQIEQMiU8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xVZNT-000000004XS-3asL;
	Mon, 23 Nov 2026 19:06:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <zlang@kernel.org>) id 1xVZNS-000000004XM-2kzr
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 19:06:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EzjGQCbWhisriS4842HHUs9cnA100PfIu86lZFwgK2Q=; b=gK9GNs5tHZakPb7F6wrzAsBgPs
 IQlUQ3sAxzebtXSOAUq8zfth46+vJIOyZhwL8OSsRozAx5zSIF0IKVVyZmpwHe6Hs3ZnV+PIHTKjg
 IrvuIL8c/fumZdjREwo1sA36Ho0Fee8nXiESLwyyI7STJburpeJ61XtKuYbeNONYuf/w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EzjGQCbWhisriS4842HHUs9cnA100PfIu86lZFwgK2Q=; b=RLiEFO1uS8EbXSZgfTHT9+tvEF
 yD1sVigWPpergecLJmJ80m0/cYBV16A7Up/iteL/1xebm3GNHFY9ljJGkQO1v4AWISWFJ+84A9eI8
 OBmhicN3UIjbdd7xxsGqKltxN1YDHiwZ52Ih8saGQ6+MdKtu7iRwBILkq3VxY873Rjrk=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVZNP-000000004Cf-3kFH
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 19:06:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8133B43360
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 19:06:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F291F000C0;
 Mon, 23 Nov 2026 19:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795460810;
 bh=EzjGQCbWhisriS4842HHUs9cnA100PfIu86lZFwgK2Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=b0C6ksNJbze9dWZIz/YUXOx84s+NfPfHLKTYHO7w9rExchBRp6DQnh/UqJVZQjily
 yEBn6xCmdZ4sN6KH/N0LeeRd/JIkKegBb7d0162LShhEPLdGkal8RIRnIc2jvjW4O7
 9am6K9UlqjUWv2Z3ey9rh1jo28PJ1kTiJJZbW3PgDuGcEqW7I0r6JKt+5zRet/y/Gr
 uk1oFOuNqk5znup2mr5nB0AjobnX0ZH7J00HVKUt8qCpg3Mp+v2pssffUFt5o/gyEd
 Qvv81ccHoV4kTgdxk3/zHB4AU6+FszjAcEdiT0xG7M9H75VpzMtrEXzeuPUGcYjYAb
 yNFoHKBogPqjg==
Date: Tue, 24 Nov 2026 03:06:42 +0800
To: Anand Jain <asj@kernel.org>
Message-ID: <awSOU4pH_5iTv9Ea@zlang-mailbox>
Mail-Followup-To: Anand Jain <asj@kernel.org>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net
References: <cover.1791272793.git.asj@kernel.org>
 <7c2209a7384968d252763bfd35289f776ebdd1af.1791272793.git.asj@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7c2209a7384968d252763bfd35289f776ebdd1af.1791272793.git.asj@kernel.org>
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVZNP-000000004Cf-3kFH
Subject: Re: [f2fs-dev] [PATCH 19/21] fstests: generic/744: use new helper
 _require_clone_mount()
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

On Tue, Oct 06, 2026 at 04:55:45PM +0800, Anand Jain wrote:
> Replace _require_duplicate_fsid() with the newly introduced
> _require_clone_mount() helper to verify kernel support for mounting
> cloned block devices with duplicate UUIDs.
> 
> Signed-off-by: Anand Jain <asj@kernel.org>
> ---

Reviewed-by: Zorro Lang <zlang@kernel.org>

>  common/rc         | 14 --------------
>  tests/generic/744 |  8 ++++----
>  2 files changed, 4 insertions(+), 18 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 7feeec04a500..58e4c234b0f4 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -6235,20 +6235,6 @@ _random_file() {
>  	echo "$basedir/$(ls -U $basedir | shuf -n 1)"
>  }
>  
> -_require_duplicate_fsid()
> -{
> -	case "$FSTYP" in
> -	"btrfs")
> -		_require_btrfs_fs_feature temp_fsid
> -		;;
> -	"ext4")
> -		;;
> -	*)
> -		_notrun "$FSTYP does not support duplicate fsid"
> -		;;
> -	esac
> -}
> -
>  # Can we find a program in the $PATH?
>  _have_program() {
>  	command -v "$1" &>/dev/null
> diff --git a/tests/generic/744 b/tests/generic/744
> index cda10e0f66ba..330d86ce826a 100755
> --- a/tests/generic/744
> +++ b/tests/generic/744
> @@ -25,8 +25,7 @@ _cleanup()
>  . ./common/filter
>  . ./common/reflink
>  
> -# Modify as appropriate.
> -_require_duplicate_fsid
> +_require_clone_mount
>  _require_test
>  _require_block_device $TEST_DEV
>  _require_test_reflink
> @@ -66,11 +65,12 @@ loop_dev2=$(_create_loop_device "$loop_file2")
>  clone_filesystem ${loop_dev1} ${loop_dev2}
>  
>  # Mounting original device
> -_mount $loop_dev1 $mnt1
> +_mount $(_common_dev_mount_options) $(_clone_mount_options) $loop_dev1 $mnt1
>  $XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $mnt1/foo | _filter_xfs_io
>  
>  # Mounting cloned device
> -_mount $loop_dev2 $mnt2 || _fail "mount of cloned device failed"
> +_mount $(_common_dev_mount_options) $(_clone_mount_options) $loop_dev2 $mnt2 \
> +					|| _fail "mount of cloned device failed"
>  
>  # cp reflink across two different filesystems must fail
>  _cp_reflink $mnt1/foo $mnt2/bar 2>&1 | _filter_test_dir
> -- 
> 2.43.0
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
