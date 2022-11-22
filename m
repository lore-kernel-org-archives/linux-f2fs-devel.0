Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C80C4332F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 22 Nov 2022 14:57:05 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oxUhq-0001g5-MT;
	Tue, 22 Nov 2022 14:57:02 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <dsterba@suse.cz>) id 1oxUhp-0001el-7c
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Nov 2022 14:57:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=at6y+TTS2oVXMolCIvQb3yxpVnbineUdxV9fGtNxfj4=; b=RuqjCZmISzPVqq7qeCWKCGKVGc
 FxMGZuK+omi/G4v/5aOZLFbuQphnISWLr3VRG6ZfIyZNpccicXF0OR+rmb82ubO1HivJkBigQwZAh
 Z3C4u7OIlC/8LfhGhKDcmQhFiTJoOnmjW0Mf/OTBAouOwJJEF28p0ogM7hnx3MSTkqPQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Reply-To:Message-ID:
 Subject:Cc:To:From:Date:Sender:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=at6y+TTS2oVXMolCIvQb3yxpVnbineUdxV9fGtNxfj4=; b=hhdwnr/Y3123QehcpJJbkE8CdT
 pUiKscM2qXH9R/HJwxIr0T68Tv8tT4ht8KDGwgKTtqls+Li6+Jw1diOQYSz++aoVMIXR0Dx/ss4/J
 vM72PIvDwhg3cNvX8Or1rZYmYcDiOgLs7jTa9WmqQAAzrevvrQrha+7Eu4MrJqnwRwzo=;
Received: from smtp-out2.suse.de ([195.135.220.29])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1oxUhg-00C6a9-25 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Nov 2022 14:57:01 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C12EA1F85D;
 Tue, 22 Nov 2022 14:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669129005;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=at6y+TTS2oVXMolCIvQb3yxpVnbineUdxV9fGtNxfj4=;
 b=zLRw/arWcUItGvQQk81m0Q0MzGiML2vcj/dEs3DO6QaUsXJRNv1MBXNe/VvXZNvQIgwcFW
 f/8WniJE7hKwXnS1PQpVQXcRK1CXDJmUkifVVi5Z2onjTKVsqJBLjnRjXfeVvAe1cTgFW7
 ZVINEJVKUtklvunA/yNYDGjb6pvTnBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669129005;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=at6y+TTS2oVXMolCIvQb3yxpVnbineUdxV9fGtNxfj4=;
 b=gVo3iIsAvA6V6/B4tE3nZfbtatg4VQ9mzj/DiSLbBgjm/M78VvqsipK8uGqyn3zizV4Rm6
 EZ+NlKRNIRNhV3AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 829D113B01;
 Tue, 22 Nov 2022 14:56:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id WQXfHi3jfGNDBAAAMHmgww
 (envelope-from <dsterba@suse.cz>); Tue, 22 Nov 2022 14:56:45 +0000
Date: Tue, 22 Nov 2022 15:56:15 +0100
From: David Sterba <dsterba@suse.cz>
To: Alexander Potapenko <glider@google.com>
Message-ID: <20221122145615.GE5824@twin.jikos.cz>
References: <20221121112134.407362-1-glider@google.com>
 <20221121112134.407362-2-glider@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221121112134.407362-2-glider@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Headers-End: 1oxUhg-00C6a9-25
Subject: Re: [f2fs-dev] [PATCH 2/5] fs: affs: initialize fsdata in
 affs_truncate()
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
Cc: tytso@mit.edu, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@kernel.org>,
 adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 akpm@linux-foundation.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Nov 21, 2022 at 12:21:31PM +0100, Alexander Potapenko wrote:
> When aops->write_begin() does not initialize fsdata, KMSAN may report
> an error passing the latter to aops->write_end().
> 
> Fix this by unconditionally initializing fsdata.
> 
> Suggested-by: Eric Biggers <ebiggers@kernel.org>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Alexander Potapenko <glider@google.com>

With the fixed Fixes: reference,

Acked-by: David Sterba <dsterba@suse.com>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
