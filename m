From: Chao Yu <yuchaochina@hotmail.com>
Subject: Re: [RFC] maintain stable and dev code separately
Date: Thu, 2 Jul 2015 20:38:35 +0800
Message-ID: <COL402-EAS2383A747DA49288EB2BD0A9AB970@phx.gbl>
References: <00f501d0b3a1$d8443680$88cca380$@samsung.com>
	<20150701024129.GA8242@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchaochina@hotmail.com>) id 1ZAdlS-00009N-Mf
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 02 Jul 2015 12:38:50 +0000
Received: from col004-omc3s7.hotmail.com ([65.55.34.145])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZAdlN-0000TK-Ab
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 02 Jul 2015 12:38:50 +0000
In-Reply-To: <20150701024129.GA8242@jaegeuk-mac02.mot.com>
Content-Language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>, 'Chao Yu' <chao2.yu@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Wednesday, July 01, 2015 10:42 AM
> To: Chao Yu; Chao Yu
> Cc: linux-f2fs-devel@lists.sourceforge.net; linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [RFC] maintain stable and dev code separately
> 
> On Wed, Jul 01, 2015 at 10:00:52AM +0800, Chao Yu wrote:
> > Hi Jaegeuk,
> >
> > Now in our f2fs git repository, we have only one major 'dev' branch
> > for collecting last reviewed and tested patches.
> >
> > And in merge window of Linux, we do not update dev branch with last
> > patches, so in this period of two weeks, it's hard for your developers
> > to rebase the right and last dev branch for developing, and there maybe
> > more conflict when we merge patches.
> >
> > Have you considered to maintain stable and dev code separately?
> > Something like:
> >
> > One 'devel' branch updated with new patches after being reviewed and tested;
> > One 'stable' branch updated periodically from 'devel' branch.
> >
> > In merge window linus can pull all patches from 'stable' branch, and meanwhile
> > we can develop base on 'devel' branch.
> >
> > And also Fengguang Wu's lkp project can test both branch well, especially for
> > last patches sent in merge window.
> 
> Good suggestion.
> I've also thought about that actually.
> 
> I created and pushed *dev-test* branch for the testing purpose in order to avoid
> any conflicts on *dev* branch.
> 
> I'll keep *dev* branch for linux-next and we can use *dev-test* branch for
> upcoming changeable patches.

Great!

Thank you for your quickly replaying and action, now it's easy for me
to rebase the last dev code for any testing and developing. :)

Thanks,

> 
> Thanks,


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
