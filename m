Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2376DD3942C
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  2 Apr 2026 14:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T8HDeWmSfHHbrcjsPrAJE9h4NgKz5ZISboY1IzofV8s=; b=CMWIa3fCqGUnG7fhOnV48ZndoW
	SCyB9IFiMuymYCHwPaEbEGqeFK9lnsHj96yGntGPLfOOVPWlJiP8XPRPXE4SnQYvt+mozqSCiXJP2
	zfAIYS2oHrvegu/cmHjJv7aqj/Qi7+tRiOQmFngrCV7QIRer/2QqlTp8vV/uUcwt5l8A=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w8IdQ-000074-L0;
	Thu, 02 Apr 2026 14:03:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@redhat.com>) id 1w8IdQ-00006x-5h
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 02 Apr 2026 14:03:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:In-Reply-To:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=c8VJHK7d7kEAfjuBkOl9dg73X5S+EbES2+s86mo3ZVk=; b=mvY1bRoKevNhSAFi/Ta4cF9hON
 ENm3iqhJ/XsiBLYCx/CsB28m18xwytpbjPw3J8J3NF1aLmQ2EKYtY8NZmC5SdewSlEtPgSvG1J7vf
 XcMr17D+Nv2jiztPr3qg/5gSFewuWeCgSILubkF72H80ff54QzKEkJGxq36EUnzcr6f4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=c8VJHK7d7kEAfjuBkOl9dg73X5S+EbES2+s86mo3ZVk=; b=BENtI1z3pUZqMRt4IP6OV1sGqK
 U5nA44xtxFEmJVmkh2wPW+yJFKvfCZJ1csXmlNoArs6KZW93tE++pAdpFAI08fvMnakbUhNvhROgn
 SEDIbVr2e4sdU0WSSvlFuSAevdg20zv8jtmvElo4A+QomQd4vAs6r3gcI9DWZCqqh5Eg=;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w8IdP-0002Wv-Jw for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 02 Apr 2026 14:03:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775138573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c8VJHK7d7kEAfjuBkOl9dg73X5S+EbES2+s86mo3ZVk=;
 b=XY6n7m1gNSVpch7FSQuknCL6QmH90fjFIXmmk9SE6Ueg4+KyRLz197cZiWMaCsBNeS260u
 DxHajBcx+GzEcR7hPHIiP+3bEBR5dpeJxsubiWbRAYBag0JOICNkhRjrFr0MXpI8h0qFTQ
 /1ukXi4g6bu1/KVxgpTRDTxTMeTOqdM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-UMc_qixRO9WaI5q10F6Qhw-1; Thu, 02 Apr 2026 10:02:52 -0400
X-MC-Unique: UMc_qixRO9WaI5q10F6Qhw-1
X-Mimecast-MFC-AGG-ID: UMc_qixRO9WaI5q10F6Qhw_1775138571
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4888b17ffa6so7101065e9.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 02 Apr 2026 07:02:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775138571; x=1775743371;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c8VJHK7d7kEAfjuBkOl9dg73X5S+EbES2+s86mo3ZVk=;
 b=KGMVkPqbgHO//9/dG88OhWm9/44IBVtbhykP6G7lk+2czVLpqvAFoLxuYXrJ8R/toi
 PuvRJvLpwftRes5nfeyq+pZAFjmLcWU4/C8r+NHZAgtT7/tGOVTql+gmD0Lx3/eskfRB
 4vSvrGtUYiZHE+8UgUOZzWIAVBjMYP/viafCyfukgXFIsrmrTvCxrAKyJ+4+dCyirBF/
 6aidKCIaDOJv0ejlzEkicOpIRvdDMk5/HIK74tz8seF1o9YnkvRBO/ZcpBJtrpRJr6IJ
 6rYEIMu/4qp+vCKb15lFGpXG/dkPqOXwE+i7z3g9WAsspnfuIRIgfIvmBYLCw/aMExAW
 eF7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFjplM7uUQR6IfS5KAM8uzNgHvmNJQPHHoKP0f8RgXnTZ9YE6YnofONBThZWURbCpIqlcalZ3M4sGsnnA+9d4G@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzArQ/IdoBowfEQwIUybiCP2lSebZ6D+a5HLNWY9hkk4aDhTBfI
 vY/t/Ue8+zRobvT4ZQNxUnaBVv3cQOcguCuuSQDfpGjxnezsNoK8aoQGaRoty8UU5aPAUe11Bo3
 u3rH1DKsTh6hV53Lv0dnBbOLW3L9X+CjoUNbMw1ACljCLjY+KZvw2ZXqODYCj0WFXHxrfMjj8co
 CAZg==
X-Gm-Gg: ATEYQzygSGjUbJoXkzW4sxRAEu7BaUhlfXd0Q5YrInMPg8NEGPOn1LvzzsCQ1d6AdrK
 R+69BQmU9QRYZHOflqUVxB87u/OXs7GR5YUyYjYk69+hSK/lWwjfWRcxrxyC9S7SpX3JDho2kxZ
 9+wjGYepi2Pz2OUCdsMATnByGTzzLeyREK48BLmj4eHiJi+vGyd5y1TAK17LAMjor4yGQHne2BS
 Lt3Vkq4Xb3h1duhX3Fk9uTE4r8QQgp+O9QqLr2TG0cuaGTS+XnBeX0FWajPZBQuXBp4uCINwwi0
 5FQ9ZUbtdN3yj6tIpF/BEwyPwMgVJFkhEF4K+ZooL9YXO1H+1P8ev0ArT93WwamIRWv4VHC55/V
 86ryKNa5ue7whuQ==
X-Received: by 2002:a05:600c:310d:b0:487:18c:7acf with SMTP id
 5b1f17b1804b1-48883599311mr128837395e9.25.1775138570824; 
 Thu, 02 Apr 2026 07:02:50 -0700 (PDT)
X-Received: by 2002:a05:600c:310d:b0:487:18c:7acf with SMTP id
 5b1f17b1804b1-48883599311mr128836745e9.25.1775138570201; 
 Thu, 02 Apr 2026 07:02:50 -0700 (PDT)
Received: from thinky ([91.245.205.131]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4e6224sm8771795f8f.25.2026.04.02.07.02.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 07:02:49 -0700 (PDT)
Date: Thu, 2 Apr 2026 16:02:47 +0200
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <giol5m6uy5ech26k4cnthqicx7qjzbg6kt6mfg7cyrvbrwwcjd@yi53k4epbu3q>
References: <20260331212827.2631020-1-aalbersh@kernel.org>
 <20260331212827.2631020-3-aalbersh@kernel.org>
 <20260401220241.GG2466@quark>
MIME-Version: 1.0
In-Reply-To: <20260401220241.GG2466@quark>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JksPNmfia4tsT6zp2eZxoC_gomOTGKia40UlHdjNVlI_1775138571
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Headers-End: 1w8IdP-0002Wv-Jw
Subject: Re: [f2fs-dev] [PATCH v6 02/22] fsverity: expose
 ensure_fsverity_info()
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
From: Andrey Albershteyn via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, Andrey Albershteyn <aalbersh@kernel.org>,
 djwong@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, hch@lst.de, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2026-04-01 15:02:41, Eric Biggers wrote:
> On Tue, Mar 31, 2026 at 11:28:03PM +0200, Andrey Albershteyn wrote:
> > This function will be used by XFS's scrub to force fsverity activation,
> > therefore, to read fsverity context.
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> 
> Acked-by: Eric Biggers <ebiggers@kernel.org>
> 
> > +/**
> > + * fsverity_ensure_verity_info() - create verity info if it's not in memory yet
> > + * @inode: the inode for which verity info should be created
> > + *
> > + * Ensure this inode has verity info attached to it. Read fsverity descriptor
> > + * and creates verity based on that. Inodes opened outside of
> > + * file_operations->open will not have any verity info attached. This
> > + * info is required for any fsverity related operations.
> > + *
> > + * Return: 0 on success, -errno on failure
> > + */
> > +int fsverity_ensure_verity_info(struct inode *inode);
> 
> As Christoph mentioned, fs/verity/ uses the convention of the kerneldoc
> for functions being above the function definition.
> 
> I think the comment could also be clearer:
> 
> > create verity info if it's not in memory yet
> 
> Maybe "cache verity info if it's not already cached", to avoid potential
> confusion with enabling fsverity on the file.
> 
> > Ensure this inode has verity info attached to it.
> 
> Maybe add: "It's assumed the inode already has fsverity enabled."
> 
> > Inodes opened outside of file_operations->open will not have any
> > verity info attached. This info is required for any fsverity
> > related operations.
> 
> The first sentence could be misinterpreted as saying that this function
> won't do anything in that case.  The second sentence isn't clear what
> counts as "any fsverity related operation".  Also "opened" doesn't seem
> like the right word to use when talking about a filesystem-internal read
> that occurs without a file descriptor having been opened.
> 
> Maybe replace with:
> 
> * This needs to be called at least once before any of the inode's data
> * can be verified (and thus read at all) or the inode's fsverity digest
> * retrieved.  fsverity_file_open() calls this already, which handles
> * normal file accesses.  If a filesystem does any internal (i.e. not
> * associated with a file descriptor) reads of the file's data or
> * fsverity digest, it must call this explicitly before doing so.
> 
> By the way, should there be a patch that converts
> ovl_ensure_verity_loaded() to use this?

sure, I will add a patch on top replacing ovl's function

-- 
- Andrey



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
