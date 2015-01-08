From: Eric Sandeen <sandeen@sandeen.net>
Subject: Re: [PATCH 2/6] f2fs: support goingdown for fs shutdown
Date: Thu, 08 Jan 2015 14:33:17 -0600
Message-ID: <54AEE98D.5010103@sandeen.net>
References: <1420740661-72288-1-git-send-email-jaegeuk@kernel.org> <1420740661-72288-2-git-send-email-jaegeuk@kernel.org> <54AEE06C.90806@sandeen.net> <20150108201843.GA74570@jaegeuk-mac02>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20150108201843.GA74570@jaegeuk-mac02>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 1/8/15 2:18 PM, Jaegeuk Kim wrote:
> On Thu, Jan 08, 2015 at 01:54:20PM -0600, Eric Sandeen wrote:
>> On 1/8/15 12:10 PM, Jaegeuk Kim wrote:
>>> This patch add an ioctl to shutdown f2fs, which stops all the further block
>>> writes after this point.
>>
>> would it make sense to just re-use the xfs ioctl nr, if the semantics are
>> the same?
> 
> The semantics are not same for now.
> In order to reuse xfs ioctl, it needs to support options for flushing logs.

the xfs iotl has 3 behaviors optional:

#define XFS_FSOP_GOING_FLAGS_DEFAULT            0x0     /* going down */
#define XFS_FSOP_GOING_FLAGS_LOGFLUSH           0x1     /* flush log but not data */
#define XFS_FSOP_GOING_FLAGS_NOLOGFLUSH         0x2     /* don't flush log nor data */

if f2fs currently supports a subset, you could just -EOPNOTSUPP on the others.

If the semantics are completely different, maybe it shouldn't share the
name at all.  ;)

Just a thought...

-Eric

> Thanks,
> 
>>
>> That way any test using it will "just work" on f2fs...
>>
>> -Eric

