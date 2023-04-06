Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 548C3C7618D
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  6 Apr 2023 14:17:48 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pkQQr-0007FB-90;
	Thu, 06 Apr 2023 14:17:46 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <dsterba@suse.cz>) id 1pkQQn-0007F4-OJ
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Apr 2023 14:17:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XIwFAYmq+ddhYZF0Zfe4K0b1+UJuE82HHInNFEctczc=; b=ibpKxDY+yvH4IPz236Jmd/JbOh
 NM33ZROtTTdeocjwh/JHjVjM4jDsxXNvd9M04kdQCRfyIEKmiTAWxF/Sq9h6Yf2uoeU8fU/L2c0W4
 HBFdAyyLTBka0rjwRdk4HyH9EraTlPc2uFBaIaZ4v9L4wwypOSsQgHlAQ/K3xyggBt3M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Reply-To:Message-ID:
 Subject:Cc:To:From:Date:Sender:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=XIwFAYmq+ddhYZF0Zfe4K0b1+UJuE82HHInNFEctczc=; b=mzSu3BMrHgI86qM+Pd+aDAIcK2
 DOOtMwyFok3ZqsrOud1PLGhYOzn2az/6u8WLQWehKVfvKuyw1LGWoFAKroFIkZMQ2Jj7/anLYBE+W
 Qht0S9qxxVboquUg6QzPmuQQ0VBlmiC2DB+5txjAmcfSep037gak/k5slj6MuCsjB6Vs=;
Received: from smtp-out2.suse.de ([195.135.220.29])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1pkQQl-00GuYU-Tm for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Apr 2023 14:17:41 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4EE761F898;
 Thu,  6 Apr 2023 14:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1680790652;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XIwFAYmq+ddhYZF0Zfe4K0b1+UJuE82HHInNFEctczc=;
 b=ZeJlivpALd8nO/1+mor0TCnnNBCMsJ16FUvMbjtBENF8lESP30O3UQN0FbK8ak1vh1Omwl
 9TT+BNH6w2K4aPeYip1Ds2fvoITG3Q8Fm+KvriE04i9alnRCUvhm69FhfCLv5mocbumPb1
 0G+YcC5Y0BrrKYEE3HWcPauZDd0rLVE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1680790652;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XIwFAYmq+ddhYZF0Zfe4K0b1+UJuE82HHInNFEctczc=;
 b=57+ei+nga6/9LWL0dAtibPJpgEe7tVSlAh13SWgoLWDg91xKuwog3XYPUrzIaZgUJ974ZK
 mnJ0Dn3Ki8c7xoBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E50021351F;
 Thu,  6 Apr 2023 14:17:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id auwvN3vULmQXJwAAMHmgww
 (envelope-from <dsterba@suse.cz>); Thu, 06 Apr 2023 14:17:31 +0000
Date: Thu, 6 Apr 2023 16:17:29 +0200
From: David Sterba <dsterba@suse.cz>
To: Zorro Lang <zlang@kernel.org>
Message-ID: <20230406141729.GP19619@twin.jikos.cz>
References: <20230404171411.699655-1-zlang@kernel.org>
 <20230404171411.699655-6-zlang@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230404171411.699655-6-zlang@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Headers-End: 1pkQQl-00GuYU-Tm
Subject: Re: [f2fs-dev] [PATCH 5/5] fstests/MAINTAINERS: add a co-maintainer
 for btrfs testing part
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
Reply-To: dsterba@suse.cz
Cc: brauner@kernel.org, linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 ebiggers@google.com, djwong@kernel.org, amir73il@gmail.com,
 linux-unionfs@vger.kernel.org, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 fdmanana@suse.com, ocfs2-devel@oss.oracle.com, jack@suse.com,
 linux-fsdevel@vger.kernel.org, anand.jain@oracle.com,
 ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Apr 05, 2023 at 01:14:11AM +0800, Zorro Lang wrote:
> Darrick J. Wong would like to nominate Anand Jain to help more on
> btrfs testing part (tests/btrfs and common/btrfs). He would like to
> be a co-maintainer of btrfs part, will help to review and test
> fstests btrfs related patches, and I might merge from him if there's
> big patchset. So CC him besides send to fstests@ list, when you have
> a btrfs fstests patch.
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> ---
> 
> Please btrfs list help to review this change, if you agree (or no objection),
> then I'll push this change.
> 
> A co-maintainer will do:
> 1) Review patches are related with him.
> 2) Merge and test patches in his local git repo, and give the patch an ACK.
> 3) Maintainer will trust the ack from co-maintainer more (might merge directly).
> 4) Maintainer might merge from co-maintainer when he has a big patchset wait for
>    merging.
> 
> Thanks,
> Zorro
> 
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0ad12a38..9fc6c6b5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -108,6 +108,7 @@ Maintainers List
>  	  or reviewer or co-maintainer can be in cc list.
>  
>  BTRFS
> +M:	Anand Jain <anand.jain@oracle.com>

Acked-by: David Sterba <dsterba@suse.com>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
