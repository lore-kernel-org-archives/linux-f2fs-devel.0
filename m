From: JP Abgrall <jpa@google.com>
Subject: Re: SELinux context not working
Date: Thu, 19 Jun 2014 10:54:38 -0700
Message-ID: <CAKP4w2RN7mcBM_VZD061dOdksfQO7c+GtC=mfUZW+TCW2doDBQ@mail.gmail.com>
References: <53A2BC4B.9040203@westnet.com.au> <20140619112733.GA18343@jmac.lan>
	<53A2D41E.1080807@westnet.com.au> <20140619153319.GA19292@jmac.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jpa@google.com>) id 1WxgYD-0008VM-Vf
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 19 Jun 2014 17:55:06 +0000
Received: from mail-oa0-f51.google.com ([209.85.219.51])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1WxgYC-0004Dq-AC
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 19 Jun 2014 17:55:05 +0000
Received: by mail-oa0-f51.google.com with SMTP id j17so5894429oag.38
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Thu, 19 Jun 2014 10:54:58 -0700 (PDT)
In-Reply-To: <20140619153319.GA19292@jmac.lan>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, Brian Chadwick <brianchad@westnet.com.au>

On Thu, Jun 19, 2014 at 8:33 AM, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>> Any clues?
>
> If so, I suspect your sepolicy.
> Could you give me the following results?

I was stuck until:
  https://android-review.googlesource.com/#/c/96593/

------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
