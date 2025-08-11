Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 384A0C88CB9
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 11 Aug 2025 11:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=62FlHF7cCZZZT3tHHl490G0cwMpfXAQOwP345cfl4Qg=; b=ajgBjgHiB4lZPi83FVTnUq1s10
	AT8ImKTKhZ2e2SEgVJUGYLIAYOJ5cMHUXCIpXU7OIXPxkO4a15+rTHDfcwEo3fWww9DOrbkmzCDBg
	I2PQKiSBtxtwb2g9TxG4WZaUSlfReHd+IokkkCybo4FUUJ213G5a+h3JoQ7sNUxQsI0M=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ulQTn-0002uG-3z;
	Mon, 11 Aug 2025 11:14:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <tytso@mit.edu>) id 1ulQTm-0002u5-DN
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 11 Aug 2025 11:14:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yHFvHo6R+wyvHhllEY32hSJMp83zXaOzd29KX8MLnHU=; b=Dj02SW/DwPZGn7TSjFrcQM1/y+
 kkjjh3bzumEoWc2FMkIdymHDFJgBH+yXHw7/xaEzAPNzozj/fjEevO9MV6XMGQxzaCrPBwwtkv1lm
 faciR19OrDneLYdl15nLY4zOv428nKkoWY5HBP09ejpnlKNJy/csQSqapLG9Fq3owZPQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yHFvHo6R+wyvHhllEY32hSJMp83zXaOzd29KX8MLnHU=; b=KIWMrQmbtIbGm/L9bdJXjQkxoC
 ai7U9Xt2bgiIkUEmDWE2HU0N0+c7dPf+tpWbd250LbLJrLNV8KN1bKzamUJj3J7/k1d35+Ctc7YG1
 f/L2c15Q21ZEbwbtbUH3KWaLf+3OLoiQGcfKSewDVoJXM2ppcEY6ZVJ4fUTDIBA0izXw=;
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ulQTm-0001F3-Mf for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 11 Aug 2025 11:14:15 +0000
Received: from trampoline.thunk.org
 (pool-173-48-111-121.bstnma.fios.verizon.net [173.48.111.121])
 (authenticated bits=0) (User authenticated as tytso@ATHENA.MIT.EDU)
 by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 57BBDaM5029819
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Aug 2025 07:13:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
 t=1754910820; bh=yHFvHo6R+wyvHhllEY32hSJMp83zXaOzd29KX8MLnHU=;
 h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
 b=CjQtsYYRB4hjhMsFcG4MM7KsFeE/ne0VzdfIAZXYral+rbBfboazdcrCorY8copyA
 /9lJZwoxtASPD5sZV/SlFnG6XNbOiqjpEOjxnUW4WC9tSdT+NEKtkNGueJ88vuAblh
 I4eTexci9aW1BAwDNmf+Bq+UIQ/aP1lNsAJjqA8yMgP8eB0ohGD81Flq1zMxVV+jzo
 I0ZJ7vxAzqqNcJHLA6hm8X0UNbnhbZf0TsJCflzsu260J6EIuQJfOxbCCno0TBO9aE
 7uKTEs5qw7kfPPGMDMZp+/zOHXpj9Budfyg1vGCowkZgTDvwzSZcjPq6YgIr3c+YRm
 FJplTrp1n8j2A==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
 id 525CB2E00D6; Mon, 11 Aug 2025 07:13:36 -0400 (EDT)
Date: Mon, 11 Aug 2025 07:13:36 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20250811111336.GB984814@mit.edu>
References: <20250810075706.172910-1-ebiggers@kernel.org>
 <20250810075706.172910-4-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250810075706.172910-4-ebiggers@kernel.org>
X-Headers-End: 1ulQTm-0001F3-Mf
Subject: Re: [f2fs-dev] [PATCH v5 03/13] ext4: move crypt info pointer to
 fs-specific part of inode
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
Cc: fsverity@lists.linux.dev, Christian Brauner <brauner@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-fscrypt@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Sun, Aug 10, 2025 at 12:56:56AM -0700, Eric Biggers wrote:
> Move the fscrypt_inode_info pointer into the filesystem-specific part of
> the inode by adding the field ext4_inode_info::i_crypt_info and
> configuring fscrypt_operations::inode_info_offs accordingly.
> 
> This is a prerequisite for a later commit that removes
> inode::i_crypt_info, saving memory and improving cache efficiency with
> filesystems that don't support fscrypt.
> 
> Co-developed-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>

Signed-off-by: Theodore Ts'o <tytso@mit.edu>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
