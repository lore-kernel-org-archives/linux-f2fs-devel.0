Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6833606A32D
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 23 Nov 2026 18:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=JxfZ6LmR;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DaQ87gMi;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=dBAwNpHV;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ehF+5Cte
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ExWYWbHkaVk+Mwz41LZAXvIrCQocvjSg9tXQvNXxpbE=; b=JxfZ6LmRLbfLn1/lW+zc6BVRWb
	ap0xKgHQNQ3GzQOPTEyffd3pKD7eq9t6gcow7GFnrfN9S58RyU9v5JpcnSt0cIUC1XoK6aDeBATVo
	t15uGcvEZhJae/p0IvgJwjvuEbCn/MH6Z1uwsLLasRTbPsePlGqwKJbp65xLSfwMG5ro=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xVYnv-000000001ks-2m2d;
	Mon, 23 Nov 2026 18:30:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <zlang@kernel.org>) id 1xVYnj-000000001kd-1V0O
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 18:30:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BdHWMmm06jZBjgiCOkE0+gowwPvFKGIFxAD8X66Ewlk=; b=DaQ87gMiMXZqN4O2FySUbdtzwj
 zZixlfAAYL0KzF2wILsPEvityYyeWT1N05tynokggsF714yeKiMw0JRryPyXYQ9CZa8p3X9Uqzg5e
 r5MdmqKomTP6sExhVLLe0tEmNK6BZ17n50PLk1pQJ4mWj12jCQv8I75jqsL9ddMR40N8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BdHWMmm06jZBjgiCOkE0+gowwPvFKGIFxAD8X66Ewlk=; b=dBAwNpHVq/mAQEH+2i0d5sXdtd
 BU4qE+eCa9fJy3s+TPEdEuiyGIodH9JvhEh92umLIdBg0TsEzR6CpDKFB2o5xfJuCnXET0wIUgV64
 v5TSVcxYjmRM9tWnj4PODoN0Gd2EVhxHwGJPoGI7k581FXNV4JDPcAOdBf/ct1VYcwMQ=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVYni-000000003Fo-3jD9
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 18:30:03 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 757D24046D
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 18:29:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CCCA1F000D8;
 Mon, 23 Nov 2026 18:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795458597;
 bh=BdHWMmm06jZBjgiCOkE0+gowwPvFKGIFxAD8X66Ewlk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ehF+5CteBAZrpbmmiJ+LzV6QK8hBub3oSEJAy7k7nIFipUkXXd81cRQ4J/BRXAfBi
 gFeLbTbGOhNF9wua5HRsbiEtDeuv/JOXGlTC0jsFNtYbMRnIaUaE9PZT5M+pXoz5JP
 /pcoTbHdwYdfPCnjPR1BoAq+MM8rZcrY0v/5c1A2oDUUe0grn88JEcOzEVtkNPUk/0
 dGdB0ldo60hc5Wqk9Al75YAd9doF2pGews4frgqa6ebwirm8lf7q4WpmSbb3Utmbzo
 l/No0+2AdvrVZ2f/YOjMb1x7ETkANMrzE9Vx1UDt88AgRq6zLnO9TbLKDcVGH2fwST
 DbNYjbEsuR+ug==
Date: Tue, 24 Nov 2026 02:29:48 +0800
To: Anand Jain <asj@kernel.org>
Message-ID: <awSGEn5Oa3IQxzw2@zlang-mailbox>
Mail-Followup-To: Anand Jain <asj@kernel.org>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net
References: <cover.1791272793.git.asj@kernel.org>
 <8900633faf8103fe992514d07d69efc9d38e8241.1791272793.git.asj@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8900633faf8103fe992514d07d69efc9d38e8241.1791272793.git.asj@kernel.org>
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVYni-000000003Fo-3jD9
Subject: Re: [f2fs-dev] [PATCH 07/21] fstests: add SEMANAGE_PROG
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

On Tue, Oct 06, 2026 at 04:55:33PM +0800, Anand Jain wrote:
> Define `SEMANAGE_PROG` for an upcoming test case that uses `semanage(8)`.
> 
> Signed-off-by: Anand Jain <asj@kernel.org>
> ---

Reviewed-by: Zorro Lang <zlang@kernel.org>

>  common/config | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/common/config b/common/config
> index 76b43b8c6ad9..e8fecc168e5a 100644
> --- a/common/config
> +++ b/common/config
> @@ -243,6 +243,7 @@ export PARTED_PROG="$(type -P parted)"
>  export XFS_PROPERTY_PROG="$(type -P xfs_property)"
>  export FSCRYPTCTL_PROG="$(type -P fscryptctl)"
>  export FSNOTIFYWAIT_PROG="$(type -P fsnotifywait)"
> +export SEMANAGE_PROG="$(type -P semanage)"
>  
>  # udev wait functions.
>  #
> -- 
> 2.43.0
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
