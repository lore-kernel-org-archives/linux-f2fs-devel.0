From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: use bio count instead of
 F2FS_WRITEBACK page count
Date: Sun, 22 May 2016 21:10:01 +0800
Message-ID: <3a7e2bf6-fc6e-db09-9b3d-7cdd717d4560@kernel.org>
References: <1463532272-64148-1-git-send-email-jaegeuk@kernel.org>
	<1b8251a2-bc07-cfe2-21b0-c189cf74ca1f@huawei.com>
	<20160518013102.GA65174@jaegeuk.gateway>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1b4T96-0002oi-AO
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 22 May 2016 13:10:16 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1b4T94-00062E-DK
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 22 May 2016 13:10:16 +0000
In-Reply-To: <20160518013102.GA65174@jaegeuk.gateway>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2016/5/18 9:31, Jaegeuk Kim wrote:
> On Wed, May 18, 2016 at 09:17:00AM +0800, Chao Yu wrote:
>> Hi Jaegeuk,
>>
>> On 2016/5/18 8:44, Jaegeuk Kim wrote:
>>> This can reduce page counting overhead.
>>
>> We change to increase one reference for one bio, but block layer can split or
>> merge bios by itself, and write_end will be called per bio, so the reference may
>> be maintained incorrectly?
> 
> Well, block layer will merge bios in a same request, and then finally call
> end_io for each original bios, no?

Sorry for the delay, I agree with you that end_io will be called for each bios
in the merging case, and for the spliting case, IIUC, splited bio will chain to
its parent bio, the real parent's end_io won't be called until both parent bio
and bio have completed, so I think it's safe here. :)

> So far I've seen no error in any test cases.

I haven't seen any hungtask so far too.

Thanks,

------------------------------------------------------------------------------
Mobile security can be enabling, not merely restricting. Employees who
bring their own devices (BYOD) to work are irked by the imposition of MDM
restrictions. Mobile Device Manager Plus allows you to control only the
apps on BYO-devices by containerizing them, leaving personal data untouched!
https://ad.doubleclick.net/ddm/clk/304595813;131938128;j
