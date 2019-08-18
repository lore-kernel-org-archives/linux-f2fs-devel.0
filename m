Return-Path: <SRS0=2ghP=WO=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FF6C3A589
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 18 Aug 2019 20:23:37 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8EF2206BB;
	Sun, 18 Aug 2019 20:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Id6pNpG+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="deyytENQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZB/VaSl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8EF2206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hzRiC-0002TR-Nl; Sun, 18 Aug 2019 20:23:36 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1hzRiB-0002TJ-4I
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 18 Aug 2019 20:23:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Igx9LKkxc/Ed+buhGGebCgajgTQpZPfdPTrkftAeYZo=; b=Id6pNpG+q96D8Cp/o4SIAiesGp
 kVsIRbT4GV8RCeny8iyo2yVOh+dQ90jZ1j1/SU00j1pKP5rISmlFva8DEaX9PvWJRBeROu/c56TLC
 VHcbbNt3qNlIU2Q7dH9b4Tm3PcFQyvc/qok7J4q9Y9NAYuSI5zYKHhwJcvPWLzVJPbOs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Igx9LKkxc/Ed+buhGGebCgajgTQpZPfdPTrkftAeYZo=; b=deyytENQROiWFBSedXmbYuy4qj
 qwLWCBk+bn71C0TF4V9UErVvsPjzkq27OfG7FcX9lgSAlOMmAft0vkM6ttlRGlImeFuNYIzl9Gl5L
 2mk0sUJOuu5Rxb1rFJbWw6MqRRWkHjhZuk6ZQqr1bSllltlUiynD6y4p4UdkPq9U5Bxo=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hzRi7-00831e-Jl
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 18 Aug 2019 20:23:35 +0000
Received: from zzz.localdomain (c-24-5-143-220.hsd1.ca.comcast.net
 [24.5.143.220])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E0403206BB;
 Sun, 18 Aug 2019 20:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1566159806;
 bh=l4MPxofEYLzifGuPs6XDtAT9a/yuc6fcqOwyHG5pdS0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kZB/VaSlYYtF6xM0yC8ONXMb46+KVmwjvPGk2hTcqQiL7tLTsMemFe043L6R8sh33
 OhiYdoyy7swXwbQzlYelx0CWvv05WB3Ig+LQPPsj9i4UY6+9ACvkn9nKmRsQLbsfsv
 OL/iuBbbJ4zaURfruZyggkWH9QOKBH2FiCPswni4=
Date: Sun, 18 Aug 2019 13:23:24 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org
Message-ID: <20190818202324.GA1824@zzz.localdomain>
Mail-Followup-To: linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20190811213557.1970-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190811213557.1970-1-ebiggers@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Headers-End: 1hzRi7-00831e-Jl
Subject: Re: [f2fs-dev] [PATCH 0/6] fs-verity fixups
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
Cc: linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Sun, Aug 11, 2019 at 02:35:51PM -0700, Eric Biggers wrote:
> A few fixes and cleanups for fs-verity.
> 
> If there are no objections, I'll fold these into the original patches.
> 
> Eric Biggers (6):
>   fs-verity: fix crash on read error in build_merkle_tree_level()
>   ext4: skip truncate when verity in progress in ->write_begin()
>   f2fs: skip truncate when verity in progress in ->write_begin()
>   ext4: remove ext4_bio_encrypted()
>   ext4: fix comment in ext4_end_enable_verity()
>   f2fs: use EFSCORRUPTED in f2fs_get_verity_descriptor()
> 
>  fs/ext4/inode.c    |  7 +++++--
>  fs/ext4/readpage.c |  9 ---------
>  fs/ext4/verity.c   |  2 +-
>  fs/f2fs/data.c     |  2 +-
>  fs/f2fs/verity.c   |  2 +-
>  fs/verity/enable.c | 24 ++++++++++++++++--------
>  6 files changed, 24 insertions(+), 22 deletions(-)
> 
> -- 
> 2.22.0
> 

I've gone ahead and folded in these fixes.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
