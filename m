Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0907CECAAA1
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 30 Aug 2022 21:02:00 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oT8My-0000IL-3Q;
	Tue, 30 Aug 2022 21:02:00 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <viro@ftp.linux.org.uk>) id 1oT8Mw-0000IF-8H
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 30 Aug 2022 21:01:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tuW9Op8uxMm/s5nLDNhxNasVJzG36UM1W1yibCDcVxs=; b=l0XOsPl7iAIsOFFCIpf8fSr3OM
 PIe2//Spx4sJAMiieVJUF4pHJv6slk/NMAZG2S5Rey1T3kj2eBKw181Gli0UgR22flkhITU4/4n3O
 ZK3YZEgE7oaGQ07xGxV+dN1IBHM07DGzudp+AIxBm2X+znwHcqNDKnewdAsghpbmY90w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tuW9Op8uxMm/s5nLDNhxNasVJzG36UM1W1yibCDcVxs=; b=f0Ckba38UAvd8Dn+7iFPYbfRk2
 QxtRuTbjGvzLdwNf+95Rvsoj9c6bSUFAGRupox1UxOW69v7C/o26NhQ7hJiQfhQs/mBkw/WYeNFGa
 hedUvTR7/la4ZNS2szQheK/cQ+AI/CqOXvsSn9JoYaHMR8sonK1rgksbGemVUHp2VZ90=;
Received: from zeniv.linux.org.uk ([62.89.141.173])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oT8Mu-007ywL-Ao for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 30 Aug 2022 21:01:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=tuW9Op8uxMm/s5nLDNhxNasVJzG36UM1W1yibCDcVxs=; b=aMj5jIDmRLUduMeC5sf764/02f
 ix+O9yo9c/B3Sm4b7XR1aXSypCXq+DgltDjDGAmsBlEG1ToVq7myUiP1rM8IOhYK2uj+3fHSZ1j7Z
 5VZxuGEnZ6J95mysPnGaKoNBEaQgPhdWO3O7+wcwEo8i0AKPhjXObG/2OqYavyFXR/k4hGaezQQmB
 wjsYmCS2AB57s2wSPBlH3E4wXHse7WdOnuSUq4W3k207Gp88aEGSUtXQ18rG0vz25HXJsNhaK2kaQ
 Unfolnqa7450aXTHXZcm7eIsRw4slhVpR9XMNXtcfpcuNnimXuI0gGj/ROPB9zS3yJde7Vipnzt8u
 hRCPyJ5w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat
 Linux)) id 1oT8MX-00ALCc-DZ; Tue, 30 Aug 2022 21:01:33 +0000
Date: Tue, 30 Aug 2022 22:01:33 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <Yw56rVwBRg0LbC41@ZenIV>
References: <20220829235429.17902-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220829235429.17902-1-rdunlap@infradead.org>
X-Headers-End: 1oT8Mu-007ywL-Ao
Subject: Re: [f2fs-dev] [PATCH] Documentation: filesystems: correct
 possessive "its"
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
Cc: Christian Brauner <brauner@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
 linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Aug 29, 2022 at 04:54:29PM -0700, Randy Dunlap wrote:
>  compress_log_size=%u	 Support configuring compress cluster size, the size will
> -			 be 4KB * (1 << %u), 16KB is minimum size, also it's
> +			 be 4KB * (1 << %u), 16KB is minimum size, also its
>  			 default size.

That one doesn't look like possesive to me - more like "default size is 16KB and
values below that are not allowed"...


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
