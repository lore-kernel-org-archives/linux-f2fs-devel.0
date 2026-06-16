Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F974CD98E1
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 16 Jun 2026 23:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yl43H7uxnWR34rUcmYCNibVYy1PZxKkeDr9ECl/uxTY=; b=WghJasIO4OQbyQ+a0Fjb9MEbVk
	cvkMu/9D4q5ffkDxd5UV8LHuQek+/hpOIdNcQ2CLf2C67NP1IoXzC0i8CxHn9HewgGfSnnFL+21U+
	kn9XqWDiqcOzXhjf14iKBo6lj/1qq5IfeI9E5LnjJ9LlzLzW66e2UmJd4fc2mSyfmGOI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wZcnX-0003kc-PZ;
	Tue, 16 Jun 2026 23:02:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wZcnW-0003kR-SO
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 Jun 2026 23:02:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ALycoJqF47JiSW3q3qosjWMWmgc4Rn8LlDIDcPMChlY=; b=S1JFvIq0+xGIAcJrJZj0zsQLXe
 MphAU9TAXgfZzhvKVv2JV8t6AIXtGVGb4amAe2dujTK3fz9sy7OHCNH3k1taRSjxjNVRzAvrWXxf9
 2tmJ+LJvES8U/4vxNNHVz0Ckm4UOx7Peu0IQ7K6RZJrwDB+k593vYJeVt/r3JfToQcPk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ALycoJqF47JiSW3q3qosjWMWmgc4Rn8LlDIDcPMChlY=; b=WtpdqsZTzXv0pz1mFdudouJkw3
 oUxy+Y8pdKmEfSPBWsFcEF+73hbYBMHNGnDmpaPn6k3GFKPG8skvbAS52TCIDsgtrAqieDt1Z9ITB
 ZX0YkHM95KXlE7xrwdmTqwtuqQEwUnJVja3z+PTkwYJYhNJx7OKpqAsCvhW+MZlVYoKY=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wZcnW-0005Cs-OE for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 Jun 2026 23:02:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A527C402A6;
 Tue, 16 Jun 2026 23:02:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32AF71F000E9;
 Tue, 16 Jun 2026 23:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781650937;
 bh=ALycoJqF47JiSW3q3qosjWMWmgc4Rn8LlDIDcPMChlY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=UiXgzW7oJNp5oLHQKJ+Gv76OvpIPe8p65skAe0t9XSOL1cp39mb+FBktdJzMe4adZ
 WyeS9jMjNt0JXod4D1pdLs+el05lNXdpqmbq1OaAwdax0uwpGy51feTDK0YxyHMp3+
 xsE5MurJ4YYrePYXaiTgY0ApjU5KX9/Ts1LTERPAOcvKW/Ag8c9aP7MuRf0oPx19DW
 NQpHR2qrvunvGzI/1Vd2XfQl3tI82+QD39dRBxAWNjUFrTjfWUJzpezsx5tzS0Sgoz
 phE0PvPHxbC3DVPDhs699/3Zan6/0cDsBVpJ11iA6lgAFzILlc9I76mTpqOkLtRxh5
 +s+L4S8Nk66TQ==
Date: Tue, 16 Jun 2026 16:02:15 -0700
To: LiaoYuanhong-vivo <liaoyuanhong@vivo.com>
Message-ID: <20260616230215.GA1873@quark>
References: <20260615193728.GA1764@quark>
 <20260616094612.45505-1-liaoyuanhong@vivo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260616094612.45505-1-liaoyuanhong@vivo.com>
X-Headers-End: 1wZcnW-0005Cs-OE
Subject: Re: [f2fs-dev] [PATCH v3 0/3] f2fs: support encrypted inline data
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
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: corbet@lwn.net, tytso@mit.edu, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fscrypt@vger.kernel.org, skhan@linuxfoundation.org, jaegeuk@kernel.org,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Jun 16, 2026 at 05:46:12PM +0800, LiaoYuanhong-vivo wrote:
> Could you share more about the direction you have in mind for simplifying
> f2fs/ext4 contents encryption around blk-crypto?

Currently ext4 and f2fs each have two implementations of file contents
encryption and decryption:

- One where the en/decryption is done in the filesystem layer

- One where the filesystem attaches a bio_crypt_ctx to the bios and the
  en/decryption is done either in the block layer by blk-crypto-fallback
  or by inline encryption hardware

I'd like to drop the first one, for simplicity and to reduce the burden
on ongoing developments like large folio support.

> For f2fs inline_data, there is still a real space-saving benefit on phones,
> since many encrypted files are smaller than 4K. Is there any acceptable
> future direction to support this kind of inode-resident data with
> blk-crypto or hardware-wrapped keys?

It is incompatible with inline encryption hardware.  A CPU-based
solution like Intel Key Locker or RISC-V High Assurance Cryptography
could provide similar security properties.  But there's nothing for
arm64 yet.  And I should mention that no one has wanted to use Key
Locker anyway because it's really slow.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
