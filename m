From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: How do I execute regression test for f2fs?
Date: Fri, 1 Sep 2017 10:34:14 -0700
Message-ID: <20170901173414.GA6786@jaegeuk-macbookpro.roam.corp.google.com>
References: <CGME20170901051947epcms1p477656fd4bbe3f2b8d85d0f57df3c47fd@epcms1p4>
 <20170901051947epcms1p477656fd4bbe3f2b8d85d0f57df3c47fd@epcms1p4>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <jaegeuk@kernel.org>) id 1dnppl-000542-0I
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Sep 2017 17:34:21 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1dnppk-0007OZ-9z
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Sep 2017 17:34:20 +0000
Content-Disposition: inline
In-Reply-To: <20170901051947epcms1p477656fd4bbe3f2b8d85d0f57df3c47fd@epcms1p4>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Daeho Jeong <daeho.jeong@samsung.com>
Cc: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

Hi Daeho,

On 09/01, Daeho Jeong wrote:
> Hi,
> 
> I have a question about developing f2fs. :-)
> 
> I've made a patch for f2fs, but I don't know how to execute regression
> test, xfstest, for f2fs. Do you have some guide document or url about
> how to use xfstest for f2fs?

Well, xfstests already supports f2fs? You can test just with FSTYP=f2fs.

Thanks,

> 
> Otherwise, is there another regression testing method for f2fs?
> 
> Best Regards,

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
