Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 761E6C25B7E
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 31 May 2024 04:49:08 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sCuCR-00019j-5i;
	Fri, 31 May 2024 04:49:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1sCuCP-00019a-K0
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 31 May 2024 04:49:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=auXRtM2e/TLalAaEINNQJc8ISA/byjh00SGMnCvszE8=; b=amj01I4Djucp53lXNxH1bPpKQW
 A8tb5V9Jr+z0nTidezskp4O6mX8dPCS0vMYKlLksXtzC+SOPi1G5azJDJ8LjDmPfiAl/oiwnF3sDH
 ikNlEooVZezLBfTsuHi6unVuV71dsTKw5qrLzTJfrFj++HNAtN18M5Lk9+wNgu6uQzDA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=auXRtM2e/TLalAaEINNQJc8ISA/byjh00SGMnCvszE8=; b=UjpqEP79TjbCDSqjv2NBT73caj
 3Roh099NDFJtW+MrJGjJUgNg4EX5ZUp4YjwV/HKpU7yMx+nsmbMZX17DcDRQTYLIdaEcqCjzqR0a8
 qv1/F7EQzXduheD6+0mUX/WKJFGn/1ycRGrLUuwAdFyZa4MpQpskypB0ZnRrrXoQvt04=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sCuCP-0002eq-5t for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 31 May 2024 04:49:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 0A96262A27;
 Fri, 31 May 2024 04:48:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4820CC116B1;
 Fri, 31 May 2024 04:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1717130933;
 bh=rwZVOoPGbQlEDRXpL/1iSA1Qlmy2Y3mYxOuSyODH8DM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TQyewlPkyzvr81BeLKj47j+oHAqkafhoB/DIsCyjteH/CtWXrQVDA48PvKdxBmfee
 zVVS1mq2JRFLY/VqjYaHMzIM2EHhSCXNXFBZbI8I2QsYuIgrC5df9DV7TAbQSPYVTr
 1JBb6aIJPLQ0xOYth6tTT18KncAR+xuNRLJuQ4UHFvZt8VsgyKsMjqvPFNhyKlsl92
 bOwYAeQHqzAWUdtm8uCrsujcNo5y9tDP2xRew8aIvsSXyHTrtML0VdEBSzV+nsppvr
 JjG6SXii9vIY3wlq5gEHudVMg4tV7gJO+EEZIDKrBencsaHSr+SOAa4GMSNwu0jiO/
 8bIa0hL5yG7ng==
Date: Thu, 30 May 2024 21:48:51 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Eugen Hristev <eugen.hristev@collabora.com>
Message-ID: <20240531044851.GE6505@sol.localdomain>
References: <20240529082634.141286-1-eugen.hristev@collabora.com>
 <20240529082634.141286-4-eugen.hristev@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240529082634.141286-4-eugen.hristev@collabora.com>
X-Headers-End: 1sCuCP-0002eq-5t
Subject: Re: [f2fs-dev] [PATCH v17 3/7] libfs: Introduce case-insensitive
 string comparison helper
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
Cc: krisman@suse.de, brauner@kernel.org, kernel@collabora.com, tytso@mit.edu,
 jack@suse.cz, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, adilger.kernel@dilger.ca,
 viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 linux-ext4@vger.kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, May 29, 2024 at 11:26:30AM +0300, Eugen Hristev via Linux-f2fs-devel wrote:
> +	/*
> +	 * Attempt a case-sensitive match first. It is cheaper and
> +	 * should cover most lookups, including all the sane
> +	 * applications that expect a case-sensitive filesystem.
> +	 */
> +
> +	if (dirent.len == (folded_name->name ? folded_name->len : name->len) &&
> +	    !memcmp(name->name, dirent.name, dirent.len))
> +		goto out;

Shouldn't it be just 'name->len' instead of
'(folded_name->name ? folded_name->len : name->len)'?

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
